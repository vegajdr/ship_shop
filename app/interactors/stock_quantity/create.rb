# frozen_string_literal: true

class StockQuantity
  class Create
    include Interactor::Organizer

    INTERACTORS = [
      EnsureLocation,
      LoadProducts,
      IncreaseStockQuantity
    ].freeze

    organize INTERACTORS
  end
end
