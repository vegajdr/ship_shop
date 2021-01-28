# frozen_string_literal: true

class StockLevelDefault
  class Persist
    include Interactor

    def call
      context.stock_level_defaults = begin
        context
          .location
          .stock_level_defaults
          .create!(stock_level_default_params)
      end
    end

    private

    def stock_level_default_params
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
