class AircraftModelsController < ApplicationController
  before_action :set_aircraft_model, only: [:show, :update, :destroy]

  # GET /aircraft_models
  def index
    @aircraft_models = AircraftModel.all

    render json: @aircraft_models
  end

  # GET /aircraft_models/1
  def show
    render json: @aircraft_model
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

  # PATCH/PUT /aircraft_models/1
  def update
    if @aircraft_model.update(aircraft_model_params)
      render json: @aircraft_model
    else
      render json: @aircraft_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /aircraft_models/1
  def destroy
    @aircraft_model.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aircraft_model
      @aircraft_model = AircraftModel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def aircraft_model_params
      params.require(:aircraft_model).permit(:name, :additional_crew, :seats, :passengers, :cruise, :engines, :gph, :total_fuel, :payload, :endurance_distance, :endurance_hours, :cost_per_nm, :mtow, :empty_weight, :base_price)
    end
end
