Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "merchants#show"
          get "/find_all", to: "merchants#index"
          get "/random",   to: "merchants#random"
        end
      end

      resources :customers, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "customers#show"
          get "/find_all", to: "customers#index"
          get "/random",   to: "customers#random"
        end
      end

      resources :items, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "items#show"
          get "/find_all", to: "items#index"
          get "/random",   to: "items#random"
        end
      end

      resources :invoices, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "invoices#show"
          get "/find_all", to: "invoices#index"
          get "/random",   to: "invoices#random"
        end
      end

      resources :invoice_items, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "invoice_items#show"
          get "/find_all", to: "invoice_items#index"
          get "/random",   to: "invoice_items#random"
        end
      end

      resources :transactions,  only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",     to: "transactions#show"
          get "/find_all", to: "transactions#index"
          get "/random",   to: "transactions#random"
        end
      end
    end
  end
end
