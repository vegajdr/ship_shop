# frozen_string_literal: true

module Purchase
  class OrderLine < ApplicationRecord
    belongs_to :order
    belongs_to :product

    before_validation :set_amount

    def set_amount
      self.amount = quantity * product.price
    end
  end
end
