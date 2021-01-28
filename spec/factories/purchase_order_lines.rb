FactoryBot.define do
  factory :purchase_order_line do
    purchase_order { nil }
    product { nil }
  end
end
