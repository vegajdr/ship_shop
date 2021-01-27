# frozen_string_literal: true

class StockLevelDefault
  class Create
    include Interactor::Organizer

    before do
      context.collection_key = :defaults
    end

    INTERACTORS = [
      ::Location::Load,
      ::Product::Load,
      Persist
    ].freeze

    organize INTERACTORS
  end
end
