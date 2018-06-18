namespace :fse do
  namespace :import do

    desc 'Import Aircraft Model from FSEconomy'
    task :aircraft_models, [:icao_code, :name] => [:environment] do |task, args|
      AircraftModelsImporter.import(args.icao_code, args.name)
      puts "Successfully imported #{args.icao_code} - #{args.name}"
    end

  end
end
