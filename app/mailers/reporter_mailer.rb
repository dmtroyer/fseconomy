class ReporterMailer < ApplicationMailer

  def for_sale_report
    @aircraft_models = params[:aircraft_models]
    @aircrafts_by_code = Hash[@aircraft_models.map { |model| [model.icao_code, model.aircraft.for_sale.limit(10)] }]
    mail(to: 'dmtroyer@gmail.com', subject: 'FSE Aircraft Report')
  end
end
