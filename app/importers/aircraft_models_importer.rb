class AircraftModelsImporter < FseImporter

  def self.import(icao_code, name)
    # file_path = Rails.root.join('storage', 'fseconomy', 'aircraft_configs.xml')
    # xml_doc = Nokogiri::XML(File.open(file_path))
    xml_doc = Nokogiri::XML(open(uri()))
    xml_model = xml_doc.xpath('//xmlns:AircraftConfig[xmlns:MakeModel[text()=$name]]', nil, name: name).first
    raise "Model name '#{name}' not found." if xml_model.nil?

    AircraftModel.create!(
      id: xml_model.css('ModelId').text,
      name: name,
      icao_code: icao_code,
      additional_crew: xml_model.css('Crew').text,
      seats: xml_model.css('Seats').text,
      cruise_speed: xml_model.css('CruiseSpeed').text,
      num_engines: xml_model.css('Engines').text,
      gph: xml_model.css('GPH').text,
      fuel_volume: calculate_fuel_volume(xml_model),
      fuel_type: xml_model.css('FuelType').text.to_i,
      mtow: xml_model.css('MTOW').text,
      empty_weight: xml_model.css('EmptyWeight').text,
      base_price: xml_model.css('Price').text,
      engine_price: xml_model.css('EnginePrice').text
    )
  end

  def self.calculate_fuel_volume(xml_model)
    fuel_tanks = ['Ext1', 'LTip', 'LAux', 'LMain', 'Center1', 'Center2',
                  'Center3', 'RMain', 'RAux', 'RTip', 'Ext2']
    fuel_tanks.reduce(0) { |sum, tank| sum + xml_model.css(tank).text.to_i }
  end

  def self.uri
    super(:aircraft_models)
  end
end
