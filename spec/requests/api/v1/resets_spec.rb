# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/resets', type: :request do
  path '/api/v1/locations/{location_id}/reset' do
    post 'Submits a reset for given location' do
      tags 'Location Reset'
      consumes 'application/json'
      produces 'application/json'

      description <<~TEXT
        *CAUTION* This endpoint issues destructive actions. It will reset the stock quantities to a set default
        (See Stock Level Default). It will also delete all orders associated to the location.
      TEXT

      parameter name: :location_id, in: :path, type: :string, example: 1

      response '201', 'Location Reset' do
        let(:location) { create(:location) }
        let(:location_id) { location.id }

        run_test!
      end
    end
  end
end
