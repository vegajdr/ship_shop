# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :locations, only: [:index, :create] do
        resource :reset, only: [:create]
        resources :stock_level_defaults, only: [:index, :create]
        resources :stock, only: [:index, :create]
      end

      resources :products, only: [:create]
      resource :product_price_query, only: [:create]

      namespace :purchase do
        resources :orders, only: [:index, :create]
      end
    end
  end
end
