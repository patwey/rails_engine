Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants/find",     to: "merchants#show"
      get "/merchants/find_all", to: "merchants#index"
      resources :merchants,      only: [:index, :show], defaults: { format: :json }
      get "/merchants/:random",  to: "merchants#show"

      get "/customers/find",     to: "customers#show"
      get "/customers/find_all", to: "customers#index"
      resources :customers,      only: [:index, :show], defaults: { format: :json }
      get "/customers/:random",  to: "customers#show"

      get "/items/find",     to: "items#show"
      get "/items/find_all", to: "items#index"
      resources :items,      only: [:index, :show], defaults: { format: :json }
      get "/items/:random",  to: "items#show"

      resources :invoices,      only: [:index, :show], defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }
      resources :transactions,  only: [:index, :show], defaults: { format: :json }
    end
  end
end
