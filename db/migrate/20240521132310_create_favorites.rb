class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
      t.index [:customer_id, :post_id], unique: true
    end
  end
end
