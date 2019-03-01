module Api
  # Races Controller of the API
  class RacesController < ApplicationController
    protect_from_forgery with: :null_session

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
        # real implementation ...
      end
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

    # POST /api/races
    def create
      if !request.accept || request.accept == '*/*'
        render plain: :nothing, status: :ok
      else
        # real implementation
      end
    end
  end
end
