require 'spec_helper'

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'mf_feedbacks'")
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'users'")
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'issues'")
ActiveRecord::Base.connection.create_table(:mf_feedbacks) do |t|
  t.string :type
  t.integer :rating
  t.references :user
  t.references :rateable, :polymorphic => true  
  t.timestamps
end

ActiveRecord::Base.connection.create_table(:users)
ActiveRecord::Base.connection.create_table(:issues) do |t|
  t.references :user
end

class User < ActiveRecord::Base
  has_many :issues
end

class Issue < ActiveRecord::Base
  include MinimalFeedback

  attr_accessor :condition

  allow_feedback :if => proc { condition }

  belongs_to :user
end

describe Issue do
  before(:each) do
    @user = User.create
    @issue = Issue.create do |i|
      i.user = @user
    end
  end

  it 'assigns positive feedback' do
    user = User.create
    @issue.condition = true
    @issue.give_feedback(:positive, :user => user)

    @issue.feedbacks.first.type.should == :positive
  end

  it 'assigns negative feedback' do
    user = User.create
    @issue.condition = true
    @issue.give_feedback(:negative, :user => user)

    @issue.feedbacks.first.type.should == :negative
  end

  it 'cannot assign feedback if the condition is false' do
    @issue.condition = false
    expect { @issue.give_feedback(:positive, :user => @user) }.to raise_error
  end
end