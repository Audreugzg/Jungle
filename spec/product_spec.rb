require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save a valid product' do
      @category = Category.create(name:"Book")
      product = Product.new(
        name: "The Giver",
        price_cents: 1000.00,
        quantity: 10,
        category_id: @category.id
      )
      expect(product).to be_valid
    end

    it 'should not save without valid name' do
      @category = Category.create(name:"Book")
      product = Product.new(
        name: nil,
        price_cents: 1000.00,
        quantity: 10,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'should not save without valid price' do
      @category = Category.create(name:"Book")
      product = Product.new(
        name: "The Giver",
        price_cents: nil,
        quantity: 10,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'should not save without valid quantity' do
      @category = Category.create(name:"Book")
      product = Product.new(
        name: "The Giver",
        price_cents: 1000.00,
        quantity: nil,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'should not save without valid id' do
      @category = Category.create(name:"Book")
      product = Product.new(
        name: "The Giver",
        price_cents: 1000.00,
        quantity: 10,
        category_id: nil
      )
      expect(product).to_not be_valid
    end
  end
end 