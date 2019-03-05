module Api
  # Races Controller of the API
  class RacesController < ApplicationController
    before_action :set_race, only: %i[show update destroy]

    rescue_from Mongoid::Errors::DocumentNotFound do |_exception|
      render status: :not_found,
             template: error_template,
             locals: { msg: "woops: cannot find race[#{params[:id]}]" }
    end

    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.debug exception
      render plain: "woops: we do not support that content-type[#{request.accept}]",
             status: :unsupported_media_type
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
        render :show
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

    private

    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

    def error_template
      # This is crucial. Otherwise it wouldn't work.
      # Rails will call some default template
      # instead of the desired one. So we need to force
      # Rails to render the right template
      if request.accept == 'application/json'
        'api/races/error_msg.json.jbuilder'
      else
        'api/races/error_msg'
      end
    end
  end
end
