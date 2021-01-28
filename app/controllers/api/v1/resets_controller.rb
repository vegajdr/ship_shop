# frozen_string_literal: true

module Api
  module V1
    class ResetsController < ::ApplicationController
      def create
        interactor = Location::Reset.call(params: create_reset_params)

        if interactor.success?
          render json: interactor.location, status: :created
        else
          render json: { errors: interactor.errors }, status: :not_found
        end
      end

      def create_reset_params
        params.permit(:location_id)
      end
    end
  end
end
