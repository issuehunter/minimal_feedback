require 'active_record'

module MinimalFeedback
  class Feedback < ActiveRecord::Base
    self.table_name = 'mf_feedbacks'

    belongs_to :rateable, :polymorphic => true
    belongs_to :user

    validates :rating, :inclusion => { :in => [1, -1] }

    validate do
      if rateable.class.feedback_condition && !rateable.instance_eval(&rateable.class.feedback_condition)
        errors.add(:base, 'feedback is not allowed')
      end
    end

    def type
      case rating
      when 1
        :positive
      when -1
        :negative
      end
    end
  end
end