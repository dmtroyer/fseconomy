require 'csv'

class AirportsImporter

  @column_mappings = {
    'icao': 'icao_code',
    'lon':  'lng',
    'type': 'airport_type'
  }

  def self.import
    file_path = Rails.root.join('storage', 'fseconomy', 'icaodata.csv')
    airports = CSV.read(file_path)
    columns = airports.delete_at(0)
    @column_mappings.each do |k,v|
      columns[columns.index(k.to_s)] = v
    end

    Airport.import!(columns, airports)

    { airports: airports }
  end

end
