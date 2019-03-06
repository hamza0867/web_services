module Api
  class EntriesController < ApplicationController

    # GET /api/racers/:racer_id/entries
    def index
      if !request.accept || request.accept == "*/*"
        render plain: api_racer_entries_path(params[:racer_id])
      end
    end

    # GET /api/racers/:racer_id/entries/:id
    def show
      if !request.accept || request.accept == "*/*"
        render plain: api_racer_entry_path(params[:racer_id], params[:id])
      end
    end

  end
end
