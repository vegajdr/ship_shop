# frozen_string_literal: true

class Location
  class Reset
    include Interactor::Organizer

    INTERACTORS = [
      Load,
      StockLevels,
      Orders
    ].freeze

    organize INTERACTORS

    def call
      ActiveRecord::Base.transaction { super }
    end
  end
end
