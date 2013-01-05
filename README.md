# MinimalFeedback[![Build Status](https://secure.travis-ci.org/issuehunter/minimal_feedback.png)](http://travis-ci.org/issuehunter/minimal_feedback)

Feedback functionalities for ActiveRecord models

## Usage

Add to Gemfile:

```ruby
gem 'minimal_feedback'
```

Run:

```ruby
bundle install
rails generate minimal_feedback
rake db:migrate
```

## Quick Start

Let's say we have an Issue ActiveRecord model and we want to be able to give it feedback

```ruby
class User < ActiveRecord::Base
  has_many :issues
end

class Issue < ActiveRecord::Base
  include MinimalFeedback

  attr_accessor :condition

  allow_feedback :if => proc { condition }

  belongs_to :user
end
```

What would happen with this configuration:

```ruby
issue = Issue.create
issue.condition = true
issue.give_feedback(:positive)
issue.feedbacks.first.type
=> :positive

issue.give_feedback(:negative)
issue.feedbacks.last.type
=> :negative
```

If the condition proc returns false when the give_feedback method is called an ActiveRecord invalid exception is raised.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
