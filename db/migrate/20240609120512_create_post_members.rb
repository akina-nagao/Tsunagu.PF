class CreatePostMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :post_members do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.boolean :is_join, default: true, null: false 

      t.timestamps
    end
  end
end
