class AircraftsController < ApplicationController
  before_action :set_aircraft, only: [:show, :update, :destroy]

  # GET /aircrafts
  def index
    @aircrafts = Aircraft.all

    render json: @aircrafts
  end

  # GET /aircrafts/1
  def show
    render json: @aircraft
  end

  # POST /aircrafts
  def create
    @aircraft = Aircraft.new(aircraft_params)

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
      params.require(:aircraft).permit(:serial_number, :registration, :aircraft_model_id, :owner, :sale_price, :equipment_type, :rental_cost_dry, :rental_cost_wet, :rental_type, :bonus, :rental_time, :rented_by, :fuel_pct, :needs_repair, :airframe_time, :engine_time, :time_last_100hr)
    end
end
