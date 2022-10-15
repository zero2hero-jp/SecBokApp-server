Rails.application.routes.draw do
  get '/health_check', to: 'alb#health_check'

  #resources :users

  namespace :api do
    namespace :v1 do
      resources :forms, only: [:index, :show, :update]
    end
  end
end
