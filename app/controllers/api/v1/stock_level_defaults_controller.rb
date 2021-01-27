# frozen_string_literal: true

module Api
  module V1
    class StockLevelDefaultsController < ::ApplicationController
      def index
        @stock_level_defaults = begin
          Location
            .find(params[:location_id])
            .stock_level_defaults
            .includes(:product)
        end

        render json: @stock_level_defaults
      end

      def create
        interactor = ::StockLevelDefault::Create.call(params: create_stock_level_defaults_params)

        if interactor.success?
          render json: interactor.stock_level_defaults, status: :created
        else
          render json: { errors: interactor.errors }, status: :not_found
        end
      end

      def create_stock_level_defaults_params
        params
          .permit(
            :location_id,
            defaults: [
              :sku,
              :quantity
            ]
          )
      end
    end
  end
end
