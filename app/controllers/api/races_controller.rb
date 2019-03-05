module Api
  # Races Controller of the API
  class RacesController < ApplicationController
    before_action :set_race, only: %i[show update destroy]
    protect_from_forgery with: :null_session

    rescue_from Mongoid::Errors::DocumentNotFound do |_exception|
      render status: :not_found,
             template: 'api/error_msg',
             locals: { msg: "woops: cannot find race[#{params[:id]}]" }
    end

    # GET /api/races
    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races, offset=[#{params[:offset]}],"\
          " limit=[#{params[:limit]}]"
      else
        # real implementation ...
      end
    end

    # GET /api/races/1
    def show
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:id]}"
      else
        render race
      end
    end

    # POST /api/races
    def create
      if !request.accept || request.accept == '*/*'
        render plain: (params[:race][:name]).to_s, status: :ok,\
               content_type: 'text/plain'
      else
        @race = Race.new(race_params)
        if @race.save
          render plain: @race.name, status: :created
        else
          render json: @race.errors, status: :unprocessable_entity
        end
      end
    end

    # PATCH,PUT /races/1
    def update
      render json: @race if @race.update_attributes(race_params)
    end

    # DELETE /races/1
    def destroy
      @race.destroy
      render nothing: true, status: :no_content
    end

    # GET /api/races/1/results
    def results
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        # real implementation ...
      end
    end

    # GET /api/races/1/results/1
    def results_detail
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        # real implementation ...
      end
    end

    private

    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

    def race
      case request.accept
      when 'application/json'
        { json: @race, status: :ok }
      when 'application/xml'
        { action: :show }
      end
    end
  end
end
