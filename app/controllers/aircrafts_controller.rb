class AircraftsController < ApplicationController
  before_action :set_aircraft, only: [:show, :update, :destroy]
  before_action :set_aircraft_model, only: [:index, :create, :import]

  # GET /aircraft_models/1/aircrafts
  def index
  end

  # GET /aircrafts/1
  def show
  end

  # POST /aircraft_models/1/aircrafts
  def create
    @aircraft = Aircraft.new(aircraft_params.merge(aircraft_model: @aircraft_model))

    if @aircraft.save
      render json: @aircraft, status: :created, location: @aircraft
    else
      render json: @aircraft.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /aircrafts/1
  def update
    if @aircraft.update(aircraft_params)
      render json: @aircraft
    else
      render json: @aircraft.errors, status: :unprocessable_entity
    end
  end

  # DELETE /aircrafts/1
  def destroy
    @aircraft.destroy
  end

  # POST /aircraft_models/1/aircrafts/import
  def import
    results = AircraftsImporter.import(@aircraft_model)
    @aircrafts = results[:aircrafts]
    @aircraft_model.reload
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aircraft
      @aircraft = Aircraft.find(params[:id])
    end

    def set_aircraft_model
      @aircraft_model = AircraftModel.find_by_icao_code(params[:aircraft_model_icao_code])
    end

    # Only allow a trusted parameter "white list" through.
    def aircraft_params
      permitted_params = [
        :serial_number, :registration, :owner, :sale_price, :equipment_type,
        :rental_cost_dry, :rental_cost_wet, :rental_type, :distance_bonus,
        :rental_time, :rented_by, :fuel_pct, :needs_repair, :airframe_time,
        :engine_time, :time_last_100hr, :home_airport_id, :current_airport_id
      ]
      params.require(:aircraft).permit(permitted_params)
    end
end
