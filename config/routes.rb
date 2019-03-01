Rails.application.routes.draw do
  # RMM level 2 API routes
  namespace :api do
    resources :races, only: %i[index show] do
      get 'results' => 'races#results'
      get 'results/:id' => 'races#results_detail'
    end
    resources :racers, only: %i[index show] do
      get 'entries' => 'racers#entries'
      get 'entries/:id' => 'racers#entries_detail'
    end
  end
  # End of RMM level 2 API routes

  resources :racers do
    post 'entries' => 'racers#create_entry'
  end
  resources :races
end
