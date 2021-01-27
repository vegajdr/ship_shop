# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/products', type: :request do
  path '/api/v1/products' do
    post 'Registers a product' do
      tags 'Product'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
        This endpoint allows for bulk registration of products to be sold in your store. An array can be sent in the
        request body with each product's information.

        It is _important_ to note that products are identified by their SKU, therefore if a registered product is found
        with the same SKU, the information passed in the request will be ignored for that particular product.
      TEXT

      parameter name: :product, in: :body, required: true, schema: {
        type: 'object',
        properties: {
          products: {
            type: 'array',
            items: {
              '$ref': '#/components/schemas/new_product'
            }
          }
        }
      }

      response '201', 'Product Registration' do
        let(:product) do
          {
            products: [
              {
                name: 'Apple',
                description: 'Red',
                sku: '123',
                price: '1.50'
              }
            ]
          }
        end

        schema type: 'object',
               properties: {
                 products: {
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
