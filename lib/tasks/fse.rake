namespace :fse do

  namespace :import do

    desc 'Import Airports from FSEconomy'
    task :airports => [:environment] do
      AirportsImporter.import
    end

  end

end
