# frozen_string_literal: true

class StockQuantity
  class Create
    include Interactor::Organizer

    before do
      context.collection_key = :stock
    end

    INTERACTORS = [
      ::Location::Load,
      ::Product::Load,
      Increase
    ].freeze

    organize INTERACTORS
  end
end
