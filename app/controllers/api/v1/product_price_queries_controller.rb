# frozen_string_literal: true

module Api
  module V1
    class ProductPriceQueriesController < ::ApplicationController
      def create
        interactor = Product::PriceQuery.call(params: query_params)

        if interactor.success?
          render json: interactor.results, status: :created, meta: { total: interactor.total }
        else
          render json: { errors: interactor.errors }, status: :not_found
        end
      end

      def query_params
        params
          .permit(
            price_query: [
              :sku,
              :quantity
            ]
          )
      end
    end
  end
end
