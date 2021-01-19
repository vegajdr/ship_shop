# frozen_string_literal: true

class StockQuantity < ApplicationRecord
  belongs_to :location
  belongs_to :product
end
