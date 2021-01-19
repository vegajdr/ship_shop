# frozen_string_literal: true

class Product
  class Create
    include Interactor::Organizer

    INTERACTORS = [
      Ensure
    ].freeze

    organize INTERACTORS
  end
end
