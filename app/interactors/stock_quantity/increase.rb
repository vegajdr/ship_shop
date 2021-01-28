# frozen_string_literal: true

class StockQuantity
  class Increase
    include Interactor::Organizer

    before do
      context.operation = :increment
    end

    INTERACTORS = [
      Update
    ].freeze

    organize INTERACTORS
  end
end
