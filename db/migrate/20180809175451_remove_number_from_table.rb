class RemoveNumberFromTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :tables, :number
  end
end
