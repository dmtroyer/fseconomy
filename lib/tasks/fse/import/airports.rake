namespace :fse do
  namespace :import do

    desc 'Import Airports from FSEconomy'
    task :airports => [:environment] do
      results = AirportsImporter.import
      puts "Successfully imported #{results[:airports].count} airports."
    end

  end
end
