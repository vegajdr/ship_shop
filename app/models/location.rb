# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :stock_quantities, dependent: :destroy
end
