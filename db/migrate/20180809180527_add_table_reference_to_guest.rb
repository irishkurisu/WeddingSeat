class AddTableReferenceToGuest < ActiveRecord::Migration[5.2]
  def change
    add_reference :guests, :table, foreign_key: true, index: true, null: false
  end
end
