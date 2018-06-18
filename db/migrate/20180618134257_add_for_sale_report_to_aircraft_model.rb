class AddForSaleReportToAircraftModel < ActiveRecord::Migration[5.2]
  def change
    add_column :aircraft_models, :report_for_sale, :boolean, default: false
  end
end
