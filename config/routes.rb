Rails.application.routes.draw do
  # RMM level 2 API routes
  namespace 'api', as: 'api' do
    # Races routes
    get 'races' => 'races#index'
    get 'races/:id' => 'races#show'
    get 'races/:id/results' => 'races#results'
    get 'races/:race_id/results/:id' => 'races#results_detail', :as => 'race_result'

    # Racers routes
    get 'racers' => 'racers#index'
    get 'racers/:id' => 'racers#show', :as => 'racer'
    get 'racers/:racer_id/entries' => 'racers#entries'
    get 'racers/:racer_id/entries/:id' => 'racers#entries_detail'
  end
  # End of RMM level 2 API routes

  resources :racers do
    post 'entries' => 'racers#create_entry'
  end
  resources :races
end
