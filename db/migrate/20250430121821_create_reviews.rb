class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :rating
      t.text :body

      t.timestamps
    end

    add_index :reviews, [ :user_id, :book_id ], unique: true
  end
end
