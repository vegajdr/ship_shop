class StockLevelDefault < ApplicationRecord
  belongs_to :location
  belongs_to :product

  validates :product_id,
            uniqueness: {
              scope: :location_id,
              message: proc do |stock_level_default|
                "A stock level default already exists for product with SKU: #{stock_level_default.product.sku}"
              end
            }
end
