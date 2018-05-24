class AircraftsController < ApplicationController
  before_action :set_aircraft, only: [:show, :update, :destroy]

  # GET /aircrafts
  def index
    where_clause = {
      aircraft_models: { icao_code: params[:aircraft_model_icao_code] }
    }
    @aircrafts = Aircraft.joins(:aircraft_model).where(where_clause)
    render json: @aircrafts
  end

  # GET /aircrafts/1
  def show
    render json: @aircraft
  end

  # POST /aircrafts
  def create
    model = AircraftModel.find_by(icao_code: params[:aircraft_model_icao_code])
    @aircraft = Aircraft.new(aircraft_params.merge(aircraft_model: model))

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aircraft
      @aircraft = Aircraft.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def aircraft_params
      permitted_params = [
        :serial_number, :registration, :owner, :sale_price, :equipment_type,
        :rental_cost_dry, :rental_cost_wet, :rental_type, :bonus, :rental_time,
        :rented_by, :fuel_pct, :needs_repair, :airframe_time, :engine_time,
        :time_last_100hr, :home_airport_id, :current_airport_id
      ]
      params.require(:aircraft).permit(permitted_params)
    end
end
