require 'active_record'

module MinimalFeedback
  class Feedback < ActiveRecord::Base
    self.table_name = 'mf_feedbacks'

    belongs_to :rateable, :polymorphic => true

    validates :rating, :inclusion => { :in => [1, -1] }

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