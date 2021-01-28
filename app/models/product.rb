# frozen_string_literal: true

class Product < ApplicationRecord
  validates :sku, uniqueness: true
end
