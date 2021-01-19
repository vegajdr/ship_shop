# frozen_string_literal: true

class Product
  class Create
    class Ensure
      include Interactor

      def call
        products = params[:products]
        return unless products

        context.products = begin
          products.map do |product_params|
            Product
              .where(sku: product_params[:sku])
              .first_or_create!(
                product_params.except(:quantity)
              )
          end
        end
      end

      delegate :params,
               to: :context,
               private: true
    end
  end
end
