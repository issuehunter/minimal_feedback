module MinimalFeedback
  class Feedback < ActiveRecord::Base
    self.table_name = 'mf_feedbacks'

    belongs_to :rateable, :polymorphic => true
    belongs_to :user

    validate do
      if rateable.class.feedback_condition && !rateable.instance_eval(&rateable.class.feedback_condition)
        errors.add(:base, 'feedback is not allowed')
      end
    end

    class InvalidFeedbackError < StandardError; end

    def self.build(options = {}, &block)
      options.assert_valid_keys :type

      case options[:type]
      when :positive
        PositiveFeedback.new(&block)
      when :negative
        NegativeFeedback.new(&block)
      else
        raise InvalidFeedbackError
      end
    end
  end
end