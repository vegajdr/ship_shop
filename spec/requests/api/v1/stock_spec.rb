# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/stock', type: :request do
  path '/api/v1/locations/{location_id}/stock' do
    post 'Creates inventory in a location' do
      tags 'Stock'
      consumes 'application/json'
      description <<~TEXT
        This endpoint allows for the replenishing of stock for a specific set of products.

        If no location_id is provided, your default Location will be used to add the provided stock amounts.

        For convenience it creates products that have not been registered based on the product SKU. If a product has
        already been registered with the SKU provided, other attributes for the product will be ignored and the product
        object will not be updated, only the stock quantities for the given location
      TEXT

      parameter name: :location_id, in: :path, type: :string

      parameter name: :stock, in: :body, schema: {
        type: 'object',
        properties: {
          products: {
            type: 'array',
            items: {
              '$ref': '#/components/schemas/product'
            }
          }
        }
      }

      response '201', 'Stock levels created' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        # FIXME: Change this let
        let(:stock) { { test: 'vega' } }

        run_test!
      end
    end
  end
end
