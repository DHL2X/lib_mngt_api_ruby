class AddServerToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :server, foreign_key: true
  end
end
