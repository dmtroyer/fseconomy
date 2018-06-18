class ReporterMailer < ApplicationMailer
  helper MailerHelper

  def for_sale_report
    @aircraft_models = params[:aircraft_models]
    @aircrafts_by_code = aircrafts_for_models_by_icao_code(@aircraft_models)
    mail to: 'dmtroyer@gmail.com', subject: 'FSE Aircraft Report'
  end

  private def aircrafts_for_models_by_icao_code(models)
    Hash[models.map { |model| [model.icao_code, model.aircraft.for_sale.limit(10)] }]
  end
end
