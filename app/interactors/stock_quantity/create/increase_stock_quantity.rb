# frozen_string_literal: true

class StockQuantity
  class Create
    class IncreaseStockQuantity
      include Interactor

      def call
        return unless params[:products]

        context.stock_quantities = []
        context.products = context.products.each(&increase_stock_quantity)
      end

      private

      delegate :params,
               to: :context,
               private: true

      def stock_quantities_relation
        @stock_quantities_relation ||= begin
          context
            .location
            .stock_quantities
            .joins(:product)
        end
      end

      def increase_stock_quantity
        proc do |product|
          stock_quantity = ensure_stock_quantity(product)

          increment_quantity(stock_quantity, product)
          context.stock_quantities << stock_quantity
        end
      end

      def ensure_stock_quantity(product)
        stock_quantities_relation
          .where(products: { sku: product.sku })
          .first_or_create!(
            product: product
          )
      end

      def increment_quantity(stock_quantity, product)
        quantity = begin
          params[:products]
            .find { |product_params| product_params[:sku] == product.sku }[:quantity]
        end

        stock_quantity.increment(:quantity, quantity)
        stock_quantity.save!
      end
    end
  end
end
