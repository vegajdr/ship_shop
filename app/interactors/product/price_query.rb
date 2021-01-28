# frozen_string_literal: true

class Product
  class PriceQuery
    include Interactor::Organizer

    before do
      context.collection_key = :price_query
    end

    INTERACTORS = [
      ::Product::Load,
      CalculateAmounts
    ].freeze

    organize INTERACTORS
  end
end
