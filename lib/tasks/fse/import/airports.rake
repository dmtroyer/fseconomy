namespace :fse do
  namespace :import do

    desc 'Import Airports from FSEconomy'
    task :airports => [:environment] do
      results = AirportsImporter.import
      puts "Successfully imported #{results[:airports].count} airports."
    end

    desc 'Import available lots from FSEconomy'
    task :airport_lots => [:environment] do
      # airports = Airport.where(state: 'British Columbia')
      airports = Airport.take(3)
      AirportsImporter.import_lots(airports)
    end

  end
end
