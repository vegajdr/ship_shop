# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/stock', type: :request do
  path '/api/v1/locations/{location_id}/stock' do
    get 'Stock index' do
      tags 'Stock'
      consumes 'application/json'
      produces 'application/json'
      description <<~TEXT
        Displays the current stock of a given location
      TEXT

      parameter name: :location_id, in: :path, type: :string, example: 1

      response '200', 'Stock Quantities' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        schema type: 'object',
               properties: {
                 stock: {
                   type: 'array',
                   items: {
                     '$ref': '#/components/schemas/stock_quantity'
                   }
                 }
               }

        run_test!
      end
    end

    post 'Creates inventory in a location' do
      tags 'Stock'
      consumes 'application/json'
      produces 'application/json'
      description <<~TEXT
        This endpoint allows for the replenishing of stock in a given location for a specific set of products.

        Requires the creation of a location and registration of products.

        If provided with duplicate SKU's inside the request body, the quantities will be totaled together
      TEXT

      parameter name: :location_id, in: :path, type: :string, example: 1

      parameter name: :stock, in: :body, required: true, schema: {
        type: 'object',
        properties: {
          stock: {
            type: 'array',
            items: {
              '$ref': '#/components/schemas/new_stock_quantity'
            }
          }
        }
      }

      response '201', 'Stock levels created' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        let(:stock) do
          {
            stock: [
              {
                sku: '123',
                quantity: 1
              }
            ]
          }
        end

        before do
          create(:product, sku: '123')
        end

        schema type: 'object',
               properties: {
                 stock: {
                   type: 'array',
                   items: {
                     '$ref': '#/components/schemas/stock_quantity'
                   }
                 }
               }

        run_test!
      end
    end
  end
end
