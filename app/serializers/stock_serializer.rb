# frozen_string_literal: true

class StockSerializer < ApplicationSerializer
  attributes :quantity,
             :amount

  has_one :product
end
