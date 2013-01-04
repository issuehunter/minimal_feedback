require 'minimal_feedback/version'
require 'minimal_feedback/feedback'
require 'active_support'

module MinimalFeedback
  extend ActiveSupport::Concern

  included do
    has_many :feedbacks, :as => :rateable, :class_name => 'MinimalFeedback::Feedback'

    class InvalidFeedbackError < StandardError; end

    cattr_accessor :feedback_condition

    def self.allow_feedback(options)
      self.feedback_condition = options[:if]
    end

    def give_feedback(*args)
      options = args.extract_options!
      type = args.first.to_sym

      feedback = Feedback.new do |f|
        f.rateable = self
        f.user = options[:user]
      end

      case type
      when :positive
        feedback.rating = 1
      when :negative
        feedback.rating = -1
      else
        raise InvalidFeedbackError
      end

      feedback.save!
    end
  end
end
