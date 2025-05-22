class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :published_year, null: false

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :author
  end
end
