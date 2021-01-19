# frozen_string_literal: true

class StockQuantity
  class Create
    class EnsureLocation
      include Interactor

      def call
        location_id = params[:location_id]
        # return unless location_id

        context.location = begin
          Location
            .where(id: location_id)
            .first_or_create
        end
      end

      delegate :params,
               to: :context,
               private: true
    end
  end
end
