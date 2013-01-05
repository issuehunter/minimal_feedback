class CreateMfFeedbacks < ActiveRecord::Migration
  def change
    create_table :mf_feedbacks do |t|
      t.string :type
      t.integer :rating
      t.references :user
      t.references :rateable, :polymorphic => true
      t.timestamps
    end
  end
end
