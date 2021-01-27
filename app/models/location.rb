# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :stock_quantities, dependent: :destroy
  has_many :stock_level_defaults, dependent: :destroy
  has_many :orders, class_name: '::Purchase::Order'

  validates :name, uniqueness: true

  def reset_stock_level
    ActiveRecord::Base.transaction do
      stock_quantities.destroy_all

      stock_level_defaults.each do |stock_level_default|
        stock_quantities.create!(product: stock_level_default.product, quantity: stock_level_default.quantity)
      end
    end
  end
end
