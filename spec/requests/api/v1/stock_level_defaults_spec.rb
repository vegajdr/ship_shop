require 'swagger_helper'

RSpec.describe 'api/stock_level_defaults', type: :request do
  path '/api/v1/locations/{location_id}/stock_level_defaults' do
    post 'Sets Inventory Default Levels for given location' do
      tags 'Stock Level Default'
      consumes 'application/json'
      produces 'application/json'
      description <<~TEXT
      TEXT

      parameter name: :location_id, in: :path, type: :string, example: 1

      parameter name: :defaults, in: :body, required: true, schema: {
        type: 'object',
        properties: {
          defaults: {
            type: 'array',
            items: {
              '$ref': '#/components/schemas/new_stock_quantity'
            }
          }
        }
      }

      response '201', 'Stock level defaults created' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        let(:defaults) do
          {
            defaults: [
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
                 defaults: {
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
