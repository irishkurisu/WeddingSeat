class AddNameToTable < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :name, :string, null: false, index: true
  end
end
