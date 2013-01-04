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
rails generate minimal_state_machine
rake db:migrate
```

## Quick Start

Let's say we have an Issue ActiveRecord model and we want to be able to give it feedback

```ruby
class Issue < ActiveRecord::Base
end
```

What would happen with this configuration:

```ruby
issue = Issue.create
issue.give_feedback(:positive)
issue.feedbacks.first.type
=> :positive

issue.give_feedback(:negative)
issue.feedbacks.last.type
=> :negative
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
