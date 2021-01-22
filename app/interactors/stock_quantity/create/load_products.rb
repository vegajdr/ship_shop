# frozen_string_literal: true

class StockQuantity
  class Create
    class LoadProducts
      include Interactor

      def call
        stock_quantities = params[:stock]
        return unless stock_quantities

        skus = stock_quantities.pluck(:sku)

        context.products = Product.where(sku: skus)
      end

      delegate :params,
               to: :context,
               private: true
    end
  end
end
