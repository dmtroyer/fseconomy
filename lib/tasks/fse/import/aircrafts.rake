namespace :fse do
  namespace :import do
    namespace :aircrafts do

      desc 'Import Aircrafts set to a particular update frequency from FSEconomy'
      task :by_frequency, [:frequency] => [:environment] do |task, args|
        models = AircraftModel.where(fse_update_frequency: args.frequency)
        models.each do |model|
          Rake::Task['fse:import:aircrafts:by_icao_code'].invoke(model.icao_code)
          Rake::Task['fse:import:aircrafts:by_icao_code'].reenable
        end
      end

      desc 'Import Aircrafts for a type from FSEconomy'
      task :by_icao_code, [:icao_code] => [:environment] do |task, args|
        aircraft_model = AircraftModel.find(args.icao_code)
        results = AircraftsImporter.import(aircraft_model)
        puts "#{results[:aircrafts].count} #{args.icao_code} aircraft imported."

        if results[:invalids].count then
          puts "There were #{results[:invalids].count} invalid #{args.icao_code} aircraft."
          results[:invalids].each do |invalid|
            puts "#{invalid.registration}: #{invalid.errors.full_messages}"
          end
        end
      end

    end
  end
end
