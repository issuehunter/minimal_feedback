require 'spec_helper'

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'mf_feedbacks'")
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'issues'")
ActiveRecord::Base.connection.create_table(:mf_feedbacks) do |t|
  t.string :type
  t.integer :rating
  t.references :rateable, :polymorphic => true  
  t.timestamps
end

ActiveRecord::Base.connection.create_table(:issues)

class Issue < ActiveRecord::Base
  include MinimalFeedback
end

describe Issue do
  before(:each) do
    @issue = Issue.create
  end

  it 'assigns positive feedback' do
    @issue.give_feedback(:positive)
    @issue.feedbacks.first.type.should == :positive
  end

  it 'assigns negative feedback' do
    @issue.give_feedback(:negative)
    @issue.feedbacks.first.type.should == :negative
  end
end