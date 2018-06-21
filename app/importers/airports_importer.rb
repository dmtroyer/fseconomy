require 'csv'

class AirportsImporter

  @column_mappings = {
    'icao': 'icao_code',
    'lon':  'lng',
    'type': 'airport_type'
  }

  def self.import
    file_path = Rails.root.join('storage', 'fseconomy', 'icaodata.csv')
    airports = CSV.read(file_path)
    columns = airports.delete_at(0)
    @column_mappings.each do |k,v|
      columns[columns.index(k.to_s)] = v
    end

    Airport.import!(columns, airports)

    { airports: airports }
  end

  def self.import_lots(airports)
    browser = Watir::Browser.new
    browser.goto 'http://server.fseconomy.net'

    login_form = browser.form(name: 'loginform')

    if login_form.exist?
      login_form.text_field(name: 'user').set(ENV['FSECONOMY_USERNAME'])
      login_form.text_field(name: 'password').set(ENV['FSECONOMY_PASSWORD'])
      login_form.input(type: 'submit').click
      login_form.input(type: 'submit').wait_while_present
    end

    airports.each do |airport|
      browser.goto "http://server.fseconomy.net/airport.jsp?icao=#{airport.icao_code}"
      Watir::Wait.until {
        browser.element(css: '.airportInfo td h1').text == airport.icao_code
      }
      lot_info = browser.element(css: '.airportInfo tr:nth-of-type(2) i').text
      airport.update_attribute(:empty_lots, self.num_lots_from_string(lot_info))
    end

    browser.close
  end

  def self.num_lots_from_string(string)
    string[/\d/].to_i
  end

end
