class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
      t.string :code
      t.decimal :lat
      t.decimal :long
      t.integer :size
      t.string :name
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
