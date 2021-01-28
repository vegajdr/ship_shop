# frozen_string_literal: true

module Api
  module V1
    module Purchase
      class OrdersController < ::ApplicationController
        def index
          @orders = begin
            Location
              .find(params[:location_id])
              .orders
          end

          render json: @orders
        end

        def create
          interactor = ::Purchase::Order::Create.call(params: create_purchase_order_params)

          if interactor.success?
            render json: interactor.order, status: :created
          else
            render json: { errors: interactor.errors }, status: :not_found
          end
        end

        def create_purchase_order_params
          params
            .permit(
              :location_id,
              products: [
                :sku,
                :quantity
              ]
            )
        end
      end
    end
  end
end
