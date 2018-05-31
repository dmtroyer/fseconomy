class ChangePricePrecisionAndScale < ActiveRecord::Migration[5.2]
  def change
    change_column :aircraft_models, :base_price, :decimal, precision: 11, scale: 2
    change_column :aircraft_models, :engine_price, :decimal, precision: 11, scale: 2
  end
end
