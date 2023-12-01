require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should_not allow_value("").for(:name) }
    it { should_not allow_value("").for(:type) }
    it { should_not allow_value("").for(:length) }
    it { should_not allow_value("").for(:width) }
    it { should_not allow_value("").for(:height) }
    it { should_not allow_value("").for(:weight) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:length) }
    it { should validate_presence_of(:width) }
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:weight) }

    it { should validate_numericality_of(:length).is_greater_than(0) }
    it { should validate_numericality_of(:width).is_greater_than(0) }
    it { should validate_numericality_of(:height).is_greater_than(0) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }

    it { should validate_uniqueness_of(:name) }
  end

  describe '.find_best_match' do
    let!(:product1) { Product.create(name: 'Small Box', type: 'Box', length: 10, width: 10, height: 10, weight: 5) }
    let!(:product2) { Product.create(name: 'Medium Box', type: 'Box', length: 15, width: 15, height: 15, weight: 10) }
    let!(:product3) { Product.create(name: 'Large Box', type: 'Box', length: 20, width: 20, height: 20, weight: 15) }

    context 'when there is a product that matches the dimensions and weight' do
      it 'returns the best match' do
        best_match = Product.find_best_match(12, 12, 12, 8)
        expect(best_match).to eq(product2) # Assuming product2 is the best match
      end

      it 'returns nil' do
        closest_match = Product.find_best_match(99, 99, 99, 99)
        expect(closest_match).to eq(nil)
      end
    end
  end
end
