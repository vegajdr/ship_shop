# frozen_string_literal: true

class Product
  class Load
    include Interactor

    def call
      sku_params = params[context.collection_key]
      return unless sku_params

      context.not_found = []
      context.products = []

      skus = sku_params.pluck(:sku).uniq
      skus.each do |sku|
        product = Product.find_by(sku: sku)

        next errors << "Product with sku: #{sku} has not been registered" unless product

        context.products << product
      end

      context.fail!(errors: errors) if errors.present?
    end

    def errors
      @errors ||= []
    end

    delegate :params,
             to: :context,
             private: true
  end
end
