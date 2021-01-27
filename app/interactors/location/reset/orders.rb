# frozen_string_literal: true

class Location
  class Reset
    class Orders
      include Interactor

      def call
        context.location.orders.destroy_all
      end
    end
  end
end
