# frozen_string_literal: true

module Api
  module V1
    class LocationsController < ::ApplicationController
      def index
        @locations = Location.all

        render json: @locations
      end

      def create
        location = Location.create!(create_location_params)

        render json: location, status: :created
      end

      def create_location_params
        params
          .require(:location)
          .permit!
      end
    end
  end
end
