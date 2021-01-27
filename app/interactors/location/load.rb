# frozen_string_literal: true

class Location
  class Load
    include Interactor

    def call
      location_id = params[:location_id]

      context.location = Location.find_by(id: location_id)

      context.fail!(errors: ['Location not found, please create a location']) unless context.location
    end

    delegate :params,
             to: :context,
             private: true
  end
end
