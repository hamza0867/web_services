module Api
  class ResultsController < ApplicationController
    before_action :set_race
    before_action :set_entrants, only: %i[index]
    before_action :set_result, only: %i[show update]

    # GET /api/races/1/results
    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        @entrants
      end
    end

    # GET /api/races/1/result/1
    def show
      if !request.accept || request.accept == '*/*'
        render plain: api_race_result_path(params[:race_id], params[:id])
      else
        render partial: 'result', object: @result, as: 'result'
      end
    end

    def update
      entrant = @result
      result = params[:result]
      # byebug
      if result
        if result[:swim]
          entrant.swim = entrant.race.race.swim
          entrant.swim_secs = result[:swim].to_f
        end
        if result[:t1]
          entrant.t1 = entrant.race.race.t1
          entrant.t1_secs = result[:t1].to_f
        end
        if result[:bike]
          entrant.bike = entrant.race.race.bike
          entrant.bike_secs = result[:bike].to_f
        end
        if result[:t2]
          entrant.t2 = entrant.race.race.t2
          entrant.t2_secs = result[:t2].to_f
        end
        if result[:run]
          entrant.run = entrant.race.race.run
          entrant.run_secs = result[:run].to_f
        end
        entrant.save
      end
      render json: entrant, status: 200
    end

    private

    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_entrants
      @entrants = @race.entrants
    end

    def set_result
      @result = @race.entrants.where(id: params[:id]).first
    end
  end
end
