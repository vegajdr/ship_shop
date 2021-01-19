require 'swagger_helper'

RSpec.describe 'api/locations', type: :request do
  path '/api/v1/locations' do
    get 'Location index' do
      tags 'Location'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT

      TEXT

      response '200', 'Location Index' do
        schema type: 'array',
               items: { '$ref': '#/components/schemas/location' }

        run_test!
      end
    end

    post 'Creates a location' do
      tags 'Location'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT

      TEXT

      parameter name: :location, in: :body, schema: { '$ref': '#/components/schemas/new_location' }

      # FIXME: Change this let
      response '201', 'Location Created' do
        let(:location) { { name: 'My Location', description: 'First store created' } }

        schema '$ref': '#/components/schemas/location'
        run_test!
      end
    end
  end
end
