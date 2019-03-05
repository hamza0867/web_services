Rails.application.routes.draw do
  # RMM level 2 API routes
  namespace :api do
    resources :races, only: %i[index show create update destroy] do
      resources :results
    end
    resources :racers, only: %i[index show] do
      resources :entries
    end
  end
  # End of RMM level 2 API routes

  resources :racers do
    post 'entries' => 'racers#create_entry'
  end
  resources :races
end
