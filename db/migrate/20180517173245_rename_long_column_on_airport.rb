class RenameLongColumnOnAirport < ActiveRecord::Migration[5.2]
  def change
    rename_column :airports, :long, :lng
  end
end
