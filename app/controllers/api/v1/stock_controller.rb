# frozen_string_literal: true

module Api
  module V1
    class StockController < ::ApplicationController
      def index
        @stock = begin
          Location
            .find(params[:location_id])
            .stock_quantities
            .includes(:product)
        end

        render json: @stock, each_serializer: ::StockSerializer, meta: { total: @stock.to_a.sum(&:amount) }
      end

      def create
        interactor = ::StockQuantity::Create.call(params: create_stock_params)

        if interactor.success?
          render json: interactor.stock_quantities, status: :created
        else
          render json: { errors: interactor.errors }, status: :not_found
        end
      end

      def create_stock_params
        params
          .permit(
            :location_id,
            stock: [
              :sku,
              :quantity
            ]
          )
      end
    end
  end
end
