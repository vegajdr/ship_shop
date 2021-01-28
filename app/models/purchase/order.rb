# frozen_string_literal: true

module Purchase
  class Order < ApplicationRecord
    belongs_to :location
    has_many :order_lines, dependent: :destroy
  end
end
