module Api
  # Races Controller of the API
  class RacesController < ApplicationController
    def index
      if !request.accept || request.accept == '*/*'
        render plain: '/api/races'
      else
        # real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:id]}"
      else
        # real implementation ...
      end
    end

    def results
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        # real implementation ...
      end
    end

    def results_detail
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        # real implementation ...
      end
    end
  end
end
