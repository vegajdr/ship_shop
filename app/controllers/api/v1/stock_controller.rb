# frozen_string_literal: true

module Api
  module V1
    class StockController < ::ApplicationController
      def index
        @stock = begin
          Location
            .find(params[:location_id])
            .stock_quantities
        end

        render json: @stock
      end

      def create
        interactor = ::StockQuantity::Create.call(params: create_stock_params)

        # FIXME: handle errors
        render json: interactor.stock_quantities, status: :created
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
