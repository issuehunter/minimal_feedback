require 'minimal_feedback/version'
require 'minimal_feedback/feedback'
require 'active_support'

module MinimalFeedback
  extend ActiveSupport::Concern

  included do
    has_many :feedbacks, :as => :rateable, :class_name => 'MinimalFeedback::Feedback'

    def give_feedback(type)
      feedback_type = type.to_sym
      case feedback_type
      when :positive
        Feedback.create(:rating => 1) { |f| f.rateable = self }
      when :negative
        Feedback.create(:rating => -1) { |f| f.rateable = self }
      end
    end
  end
end
