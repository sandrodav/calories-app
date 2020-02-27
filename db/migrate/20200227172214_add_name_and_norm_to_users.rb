class AddNameAndNormToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :norm, :decimal , default: 2000
  end
end
