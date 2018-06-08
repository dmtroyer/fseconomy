namespace :fse do

  namespace :import do

    desc 'Import Aircraft Model from FSEconomy'
    task :aircraft_model, [:icao_code, :name] => [:environment] do |task, args|
      AircraftModelsImporter.import(args.icao_code, args.name)
      puts "Successfully imported #{args.icao_code} - #{args.name}"
    end

    desc 'Import Aircrafts for a type from FSEconomy'
    task :aircrafts, [:icao_code] => [:environment] do |task, args|
      results = AircraftsImporter.import(args.icao_code)
      puts "#{results[:aircrafts].count} aircrafts imported."
      if results[:invalids].count then
        puts "There were #{results[:invalids].count} invalid aircraft."
        results[:invalids].each do |invalid|
          puts "#{invalid.registration}: #{invalid.errors.full_messages}"
        end
      end
    end

    desc 'Import Airports from FSEconomy'
    task :airports => [:environment] do
      results = AirportsImporter.import
      puts "Successfully imported #{results[:airports].count} airports."
    end

  end

end
