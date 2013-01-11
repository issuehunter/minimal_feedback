require 'minimal_feedback/version'
require 'active_support'
require 'active_record'
require 'minimal_feedback/feedback'
require 'minimal_feedback/negative_feedback'
require 'minimal_feedback/positive_feedback'

module MinimalFeedback
  extend ActiveSupport::Concern

  included do
    has_many :feedbacks, :as => :rateable, :class_name => 'MinimalFeedback::Feedback'

    cattr_accessor :feedback_condition

    def self.allow_feedback(options)
      self.feedback_condition = options[:if]
    end

    def give_feedback(*args)
      options = args.extract_options!
      type = args.first.to_sym

      feedback = Feedback.build(:type => type) do |f|
        f.rateable = self
        f.user = options[:user]
      end

      feedback.save!
    end
  end
end
