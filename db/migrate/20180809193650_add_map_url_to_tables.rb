class AddMapUrlToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :map_url, :string
  end
end
