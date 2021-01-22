# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/products', type: :request do
  path '/api/v1/products' do
    post 'Registers a product' do
      tags 'Product'
      consumes 'application/json'

      description <<~TEXT
        This endpoint allows for a bulk registration of products to be sold in your store. An array can be sent in the
        request body with each product's information.

        It is _important_ to note that products are identified by their SKU, therefore if a registered product is found
        with the same SKU, the information passed in the request will be ignored for that particular product.

        Please refer to the UpdateProduct endpoint in order to modify an existing product's information
      TEXT

      parameter name: :product, in: :body, schema: { '$ref': '#/components/schemas/new_product' }

      response '201', 'Product Registration' do
        let(:product) { { name: 'My Product', description: 'Good quality product' } }
        run_test!
      end
    end
  end
end
