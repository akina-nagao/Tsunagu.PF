class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :customer, null: false, foreigh_key: true
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
