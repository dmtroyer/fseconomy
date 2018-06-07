class AircraftModelsController < ApplicationController
  before_action :set_aircraft_model, only: [:show, :update, :destroy]

  # GET /aircraft_models
  def index
    @aircraft_models = AircraftModel.all
  end

  # GET /aircraft_models/C172
  def show
  end

  # POST /aircraft_models
  def create
    @aircraft_model = AircraftModel.new(aircraft_model_params)

    if @aircraft_model.save
      render json: @aircraft_model, status: :created, location: @aircraft_model
    else
      render json: @aircraft_model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /aircraft_models/C172
  def update
    if @aircraft_model.update(aircraft_model_params)
      render json: @aircraft_model
    else
      render json: @aircraft_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /aircraft_models/C172
  def destroy
    @aircraft_model.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aircraft_model
      @aircraft_model = AircraftModel.find_by(icao_code: params[:icao_code])
    end

    # Only allow a trusted parameter "white list" through.
    def aircraft_model_params
      params.require(:aircraft_model)
            .permit(:name, :icao_code, :additional_crew, :seats, :passengers,
                    :cruise, :engines, :gph, :total_fuel, :payload,
                    :endurance_distance, :endurance_hours, :cost_per_nm,
                    :mtow, :empty_weight, :base_price)
    end
end
