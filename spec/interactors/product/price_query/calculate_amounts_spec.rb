# frozen_string_literal: true

class Product
  class PriceQuery
    RSpec.describe CalculateAmounts, type: :interactor do
      subject(:interactor_context) { described_class.call(init_context) }

      describe '#call' do
        let(:init_context) do
          {
            products: products,
            params: params,
            collection_key: :price_query
          }
        end
        let(:products) { [first_product, second_product] }
        let(:first_product) { create(:product, sku: first_sku, price: 50.0) }
        let(:second_product) { create(:product, sku: second_sku, price: 10.0) }
        let(:first_sku) { '123' }
        let(:second_sku) { '456' }

        context 'when product information is provided' do
          let(:params) do
            {
              price_query: [
                {
                  sku: first_sku,
                  quantity: 5
                },
                {
                  sku: second_sku,
                  quantity: 10
                }
              ]
            }
          end

          it do
            expect(interactor_context.results).to match_array(
              [
                {
                  product: first_product,
                  quantity: 5,
                  unit_price: first_product.price,
                  total: 250.0
                },
                {
                  product: second_product,
                  quantity: 10,
                  unit_price: second_product.price,
                  total: 100.0
                }
              ]
            )
          end

          it { expect(interactor_context.total).to eq(350.0) }
        end

        context 'when duplicate product information is provided' do
          let(:params) do
            {
              price_query: [
                {
                  sku: first_sku,
                  quantity: 5
                },
                {
                  sku: second_sku,
                  quantity: 10
                },
                {
                  sku: second_sku,
                  quantity: 35
                }
              ]
            }
          end

          it do
            expect(interactor_context.results).to match_array(
              [
                {
                  product: first_product,
                  quantity: 5,
                  unit_price: first_product.price,
                  total: 250.0
                },
                {
                  product: second_product,
                  quantity: 45,
                  unit_price: second_product.price,
                  total: 450.0
                }
              ]
            )
          end

          it { expect(interactor_context.total).to eq(700.0) }
        end
      end
    end
  end
end
