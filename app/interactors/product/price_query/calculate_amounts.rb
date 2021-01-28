# frozen_string_literal: true

class Product
  class PriceQuery
    class CalculateAmounts
      include Interactor

      def call
        context.results = begin
          results
        end

        context.total = context.results.sum { |result| result[:total] }
      end

      private

      def results
        context.products.map do |product|
          quantity = normalized_params.find { |params| params[:sku] == product.sku }[:quantity]
          price = product.price

          {
            product: product,
            quantity: quantity,
            unit_price: price,
            total: quantity * price
          }
        end
      end

      delegate :normalize,
               to: '::UniqueSkuParams',
               private: true

      def normalized_params
        normalize(context.params[context.collection_key])
      end
    end
  end
end
