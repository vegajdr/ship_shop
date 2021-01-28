# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ::ApplicationController
      def create
        interactor = ::Product::Create.call(params: create_products_params)

        render json: interactor.products, status: :created
      end

      def create_products_params
        params
          .permit(
            products: [
              :name,
              :description,
              :sku,
              :price
            ]
          )
      end
    end
  end
end
