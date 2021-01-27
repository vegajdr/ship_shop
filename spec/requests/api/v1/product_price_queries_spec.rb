# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/product_price_queries', type: :request do
  path '/api/v1/product_price_query' do
    post 'Returns totals of products given' do
      tags 'Product Price Query'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
      TEXT

      parameter name: :price_query, in: :body, required: true, schema: {
        type: 'object',
        properties: {
          price_query: {
            type: 'array',
            items: {
              '$ref': '#/components/schemas/new_stock_quantity'
            }
          }
        }
      }

      response '201', 'Total results' do
        let(:price_query) do
          {
            price_query: [
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
                 price_query: {
                   type: 'array',
                   items: {
                     '$ref': '#/components/schemas/product'
                   }
                 }
               }

        run_test!
      end
    end
  end
end
