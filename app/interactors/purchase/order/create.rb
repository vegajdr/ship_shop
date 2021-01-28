# frozen_string_literal: true

module Purchase
  class Order
    class Create
      include Interactor::Organizer

      before do
        context.collection_key = :products
      end

      INTERACTORS = [
        ::Location::Load,
        ::Product::Load,
        ::StockQuantity::Decrease,
        Persist
      ].freeze

      organize INTERACTORS
    end
  end
end
