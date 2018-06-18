namespace :fse do
  namespace :report do

    desc 'Send the for sale report'
    task :for_sale => [:environment] do
      ReporterMailer.with(aircraft_models: AircraftModel.all_report_for_sale)
                    .for_sale_report
                    .deliver_now
      puts 'Sent the email.'
    end

  end
end
