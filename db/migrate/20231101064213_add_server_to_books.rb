class AddServerToBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :server, foreign_key: true
  end
end
