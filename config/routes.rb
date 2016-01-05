Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/api/v1/merchants/find",     to: "merchants#show"
      get "/api/v1/merchants/find_all", to: "merchants#index"
      resources :merchants,     only: [:index, :show], defaults: { format: :json }
      get "/api/v1/merchants/:random",  to: "merchants#show"

      get "/api/v1/customers/find",     to: "customers#show"
      get "/api/v1/customers/find_all", to: "customers#index"
      resources :customers,     only: [:index, :show], defaults: { format: :json }
      get "/api/v1/customers/:random",  to: "customers#show"

      get "/api/v1/items/find",     to: "items#show"
      get "/api/v1/items/find_all", to: "items#index"
      resources :items,         only: [:index, :show], defaults: { format: :json }
      get "/api/v1/customers/:random",  to: "customers#show"

      resources :invoices,      only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions,  only: [:index, :show], defaults: { format: :json }
    end
  end
end
