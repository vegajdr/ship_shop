# frozen_string_literal: true

class Location
  class Reset
    class StockLevels
      include Interactor

      def call
        context.location.reset_stock_level
      end
    end
  end
end
