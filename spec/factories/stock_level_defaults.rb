FactoryBot.define do
  factory :stock_level_default do
    location { nil }
    product { nil }
    quantity { 1 }
  end
end
