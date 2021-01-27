# frozen_string_literal: true

module Purchase
  class Order
    class Create
      class Persist
        include Interactor

        def call
          context.order = context.location.orders.create!

          context
            .order
            .order_lines
            .create!(
              order_line_params
            )
        end

        private

        def order_line_params
          context.products.map do |product|
            {
              product: product,
              quantity: normalized_params.find { |params| params[:sku] == product.sku }[:quantity]
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
end
