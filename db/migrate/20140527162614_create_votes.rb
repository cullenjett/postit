class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.string :voteable_type
      t.integer :voteable_id

      # as an alternate syntax for creating the polymorphic relationship:
      # t.references :voteable, polymorphic: true

      t.timestamps
    end
  end
end
