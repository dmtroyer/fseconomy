require 'csv'

class AirportsImporter

  def self.import
    file_path = Rails.root.join('storage', 'fseconomy', 'icaodata.csv')
    airports = CSV.read(file_path)
    columns = airports.delete_at(0)
    columns[columns.index('icao')] = 'icao_code'
    columns[columns.index('lon')] = 'lng'

    Airport.import!(columns, airports)

    puts "Successfully imported #{airports.count} airports."
  end

end
