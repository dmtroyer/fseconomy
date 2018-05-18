class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :aircrafts, :aircraft_models
  end
end
