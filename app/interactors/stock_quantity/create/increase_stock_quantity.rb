# frozen_string_literal: true

class StockQuantity
  class Create
    class IncreaseStockQuantity
      include Interactor

      def call
        return unless params[:stock]

        context.stock_quantities = []

        context.products = begin
          context.products.each(&increase_stock_quantity_proc)
        end
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

      def increase_stock_quantity_proc
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
          stock_quantity_params
            .find { |stock_params| stock_params[:sku] == product.sku }[:quantity]
        end

        stock_quantity.increment(:quantity, quantity)
        stock_quantity.save!
      end

      def stock_quantity_params
        @stock_quantity_params ||= begin
          params[:stock]
            .group_by { |stock_quantity_params| stock_quantity_params[:sku] }
            .transform_values(&to_summed_quantities_objects_proc)
            .map(&normalize_params_proc)
        end
      end

      def to_summed_quantities_objects_proc
        proc { |array| array.each_with_object({ quantity: 0 }, &sum_quantities_proc) }
      end

      def sum_quantities_proc
        proc { |itr, object|  object[:quantity] = itr[:quantity] + (object[:quantity]) }
      end

      def normalize_params_proc
        proc { |key, value| { sku: key, quantity: value[:quantity] } }
      end
    end
  end
end
