class CreateServers < ActiveRecord::Migration[7.0]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :subdomain

      t.timestamps
    end
  end
end
