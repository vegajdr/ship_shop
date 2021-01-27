# frozen_string_literal: true

class StockQuantity
  class Update
    include Interactor

    def call
      return unless params[context.collection_key]

      context.stock_quantities = []

      context.products = begin
        context.products.each(&modify_stock_quantity_proc)
      end
    end

    private

    delegate :params,
             to: :context,
             private: true

    delegate :normalize,
             to: '::UniqueSkuParams',
             private: true

    def stock_quantities_relation
      @stock_quantities_relation ||= begin
        context
          .location
          .stock_quantities
          .joins(:product)
      end
    end

    def modify_stock_quantity_proc
      proc do |product|
        stock_quantity = ensure_stock_quantity(product)

        modify_quantity(stock_quantity, product)
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

    def modify_quantity(stock_quantity, product)
      quantity = begin
        stock_quantity_params
          .find { |stock_params| stock_params[:sku] == product.sku }[:quantity]
      end

      stock_quantity.public_send(context.operation, :quantity, quantity)
      stock_quantity.save!
    end

    def stock_quantity_params
      @stock_quantity_params ||= normalize(params[context.collection_key])
    end
  end
end
