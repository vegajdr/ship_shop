# frozen_string_literal: true

class StockQuantity
  RSpec.describe Update, type: :interactor do
    subject(:interactor_context) { described_class.call(init_context) }

    describe '#call' do
      let(:init_context) do
        {
          products: products,
          params: params,
          collection_key: :stock,
          operation: :increment,
          location: location
        }
      end
      let(:location) { create(:location) }
      let(:products) { [first_product, second_product] }
      let(:first_product) { create(:product, sku: first_sku, price: 50.0) }
      let(:second_product) { create(:product, sku: second_sku, price: 10.0) }
      let(:first_sku) { '123' }
      let(:second_sku) { '456' }

      context 'when product information is provided' do
        let(:params) do
          {
            stock: [
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

        it { expect { interactor_context }.to change { StockQuantity.all.size }.by(2) }
        it { expect(interactor_context.stock_quantities).to all(be_a(StockQuantity)) }
        it { expect(interactor_context.stock_quantities.first.product).to eq(first_product) }
        it { expect(interactor_context.stock_quantities.first.quantity).to eq(5) }
        it { expect(interactor_context.stock_quantities.second.product).to eq(second_product) }
        it { expect(interactor_context.stock_quantities.second.quantity).to eq(10) }
      end

      context 'when duplicate product information is provided' do
        let(:params) do
          {
            stock: [
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

        it { expect { interactor_context }.to change { StockQuantity.all.size }.by(2) }
        it { expect(interactor_context.stock_quantities).to all(be_a(StockQuantity)) }
        it { expect(interactor_context.stock_quantities.first.product).to eq(first_product) }
        it { expect(interactor_context.stock_quantities.first.quantity).to eq(5) }
        it { expect(interactor_context.stock_quantities.second.product).to eq(second_product) }
        it { expect(interactor_context.stock_quantities.second.quantity).to eq(45) }
      end
    end
  end
end
