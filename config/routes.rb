Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",      to: "merchants#show"
          get "/find_all",  to: "merchants#index"
          get "/random",    to: "merchants#random"
          get "/most_revenue", to: "merchants_most_revenue#index"
          get ":id/revenue", to: "merchants_total_revenue#show"
        end
      end

      resources :customers, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",                 to: "customers#show"
          get "/find_all",             to: "customers#index"
          get "/random",               to: "customers#random"
          get ":id/favorite_merchant", to: "favorite_merchant#show"
        end
      end

      resources :items, only: [:index, :show], defaults: { format: :json } do
        collection do
          get "/find",         to: "items#show"
          get "/find_all",     to: "items#index"
          get "/random",       to: "items#random"
          get "/most_items",   to: "items_most_items#index"
          get "/most_revenue", to: "items_most_revenue#index"
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

      namespace :merchants do
        get ":id/items", to: "items#index"
        get ":id/invoices", to: "invoices#index"
      end

      namespace :invoices do
        get ":id/transactions",  to: "transactions#index"
        get ":id/items",         to: "items#index"
        get ":id/invoice_items", to: "invoice_items#index"
        get ":id/customer",      to: "customers#show"
        get ":id/merchant",      to: "merchants#show"
      end

      namespace :invoice_items do
        get ":id/item",    to: "items#show"
        get ":id/invoice", to: "invoices#show"
      end

      namespace :items do
        get ":id/invoice_items", to: "invoice_items#index"
        get ":id/merchant",      to: "merchants#show"
      end

      namespace :transactions do
        get ":id/invoice", to: "invoices#show"
      end

      namespace :customers do
        get ":id/invoices", to: "invoices#index"
        get ":id/transactions", to: "transactions#index"
      end
    end
  end
end
