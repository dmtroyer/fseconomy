class AddIndexToAirport < ActiveRecord::Migration[5.2]
  def change
    add_index :airports, :code
    change_column_null :airports, :code, false
    change_column :airports, :code, :string, limit: 4
  end
end
