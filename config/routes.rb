Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/api/v1/merchants/find",     to: "merchants#show"
      get "/api/v1/merchants/find_all", to: "merchants#index"
      resources :merchants,     only: [:index, :show], defaults: { format: :json }
      get "/api/v1/merchants/:random",  to: "merchants#show"

      resources :customers,     only: [:index, :show], defaults: { format: :json }
      resources :items,         only: [:index, :show], defaults: { format: :json }
      resources :invoices,      only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions,  only: [:index, :show], defaults: { format: :json }
    end
  end
end
