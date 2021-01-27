# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/orders', type: :request do
  path '/api/v1/purchase/orders' do
    get 'Order index' do
      tags 'Order'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
        List of all orders by given location
      TEXT

      parameter name: :location_id, in: :query, type: 'integer', required: true, example: 1

      response '200', 'Order Index' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        run_test!
      end
    end

    post 'Submits an order' do
      tags 'Order'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT

      TEXT

      parameter name: :location_id, in: :query, type: :string, example: 1
      parameter name: :products,
                in: :body,
                required: true,
                schema: {
                  type: 'object',
                  properties: {
                    products: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/new_stock_quantity'
                      }
                    }
                  }
                }

      response '201', 'Order Placed' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }
        let(:products) do
          {
            products: [
              {
                sku: '123',
                quantity: 1
              }
            ]
          }
        end

        before do
          product = create(:product, sku: '123')
          location.stock_quantities.create(product: product, quantity: 1)
        end

        schema '$ref': '#/components/schemas/order'

        run_test!
      end
    end
  end
end
