class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :fname, null: false
      t.string :lname, null: false

      t.timestamps
    end
  end
end
