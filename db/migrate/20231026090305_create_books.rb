class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :publication_year
      t.integer :quantity, null: false

      t.timestamps
    end
    add_index :books, :title
  end
end
