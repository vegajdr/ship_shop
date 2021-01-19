# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/products', type: :request do
  path '/api/v1/products' do
    post 'Registers a product' do
      tags 'Product'
      consumes 'application/json'

      description <<~TEXT

      TEXT

      parameter name: :product, in: :body, schema: { '$ref': '#/components/schemas/new_product' }

      # FIXME: Change this let
      response '201', 'Product Registration' do
        let(:product) { { name: 'My Product', description: 'Good quality product' } }
        run_test!
      end
    end
  end
end
