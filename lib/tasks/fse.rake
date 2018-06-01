namespace :fse do

  namespace :import do

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
      AirportsImporter.import
    end

  end

end
