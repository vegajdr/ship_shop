# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/locations', type: :request do
  path '/api/v1/locations' do
    get 'Location index' do
      tags 'Location'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
        List of all created locations
      TEXT

      response '200', 'Location Index' do
        schema type: 'object',
               properties: {
                 locations: {
                   type: 'array',
                   items: { '$ref': '#/components/schemas/location' }
                 }
               }

        run_test!
      end
    end

    post 'Creates a location' do
      tags 'Location'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
        In order to hold inventory, a location must first be created.

        The name for each location is required to be unique
      TEXT

      parameter name: :location,
                in: :body,
                required: true,
                schema: { '$ref': '#/components/schemas/new_location' }

      response '201', 'Location Created' do
        let(:location) { { name: 'My Location', description: 'First store created' } }

        schema '$ref': '#/components/schemas/location'
        run_test!
      end
    end
  end
end
