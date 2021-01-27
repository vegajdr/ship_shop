# frozen_string_literal: true

# frozen_string_literal: true

class StockQuantity
  class Decrease
    include Interactor::Organizer

    before do
      context.operation = :decrement
    end

    INTERACTORS = [
      Update
    ].freeze

    organize INTERACTORS
  end
end
