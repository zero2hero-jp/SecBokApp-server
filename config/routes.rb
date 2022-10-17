Rails.application.routes.draw do
  get '/health_check', to: 'alb#health_check'

  #resources :users

  namespace :api do
    namespace :v1 do
      resources :sheets, only: [:index, :show, :create, :update]
    end
  end
end
