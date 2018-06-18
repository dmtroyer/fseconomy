require 'open-uri'

class AircraftsImporter < FseImporter

  def self.import(icao_code)
    model = AircraftModel.find_by(icao_code: icao_code)
    raise "Cannot find the #{icao_code} model in the database." if model.nil?

    aircrafts = []
    invalids = []
    xml_doc = Nokogiri::XML(open(uri(model.name)))

    xml_doc.css('Aircraft').each do |aircraft|
      aircraft = Aircraft.new(
        id: aircraft.css('SerialNumber').text,
        registration: aircraft.css('Registration').text,
        aircraft_model: model,
        owner: aircraft.css('Owner').text,
        current_airport_id: aircraft.css('Location').text == 'In Flight' ? nil : aircraft.css('Location').text,
        home_airport_id: aircraft.css('Home').text,
        sale_price: aircraft.css('SalePrice').text,
        fees_owed: aircraft.css('FeeOwed').text,
        has_ifr_equipment: aircraft.css('Equipment').text.include?('IFR'),
        has_autopilot: aircraft.css('Equipment').text.include?('AP'),
        has_gps: aircraft.css('Equipment').text.include?('GPS'),
        rental_cost_dry: aircraft.css('RentalDry').text,
        rental_cost_wet: aircraft.css('RentalWet').text,
        distance_bonus: aircraft.css('Bonus').text,
        rental_time: aircraft.css('RentalTime').text,
        rented_by: aircraft.css('RentedBy').text == 'Not rented.' ? nil : aircraft.css('RentedBy').text,
        fuel_pct: aircraft.css('FuelPct').text,
        needs_repair: aircraft.css('NeedsRepair').text,
        airframe_time: fse_time_to_minutes(aircraft.css('AirframeTime').text),
        engine_time: fse_time_to_minutes(aircraft.css('EngineTime').text),
        time_last_100hr: fse_time_to_minutes(aircraft.css('TimeLast100hr').text)
      )

      if aircraft.validate then
        aircrafts << aircraft
      else
        invalids << aircraft
      end
    end

    Aircraft.transaction do
      Aircraft.lock.where(aircraft_model: model).delete_all
      Aircraft.import(aircrafts, validate: false)
    end

    model.update_attribute(:last_fse_update, DateTime.now)

    { aircrafts: aircrafts, invalids: invalids }
  end

  def self.uri(aircraft_name)
    super(:aircrafts, makemodel: aircraft_name)
  end

  def self.fse_time_to_minutes(time)
    time.split(':')[0].to_i * 60 + time.split(':')[1].to_i
  end

end
