Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show], defaults: { format: :json }
      resources :customers, only: [:index, :show], defaults: { format: :json }
    end
  end
end
