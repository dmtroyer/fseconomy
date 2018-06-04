class AddUpdateFrequencyToModel < ActiveRecord::Migration[5.2]
  def change
    add_column :aircraft_models, :fse_update_frequency, :integer, default: 0
    add_index :aircraft_models, :fse_update_frequency
  end
end
