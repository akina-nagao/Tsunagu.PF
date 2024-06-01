class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post
      t.references :Tag, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :post_tags, [:post_id, :tag_id], unique: true
  end
end
