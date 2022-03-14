require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) { @category = Category.create(name: 'Books') }

    it 'product will save with a name' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: 10,
          quantity: 3,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be true
    end

    it 'product will not save without a name' do
      @product =
        Product.new(name: nil, price: 10, quantity: 3, category: @category)
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end

    it 'product will save with a price' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: 10,
          quantity: 3,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be true
    end

    it 'product will not save without a price' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: nil,
          quantity: 3,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:price]).to include "can't be blank"
    end

    it 'product will save with a quantity' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: 10,
          quantity: 3,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be true
    end

    it 'product will not save without a quantity' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: 10,
          quantity: nil,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:quantity]).to include "can't be blank"
    end

    it 'product will save with a category' do
      @product =
        Product.new(
          name: 'Harry Potter',
          price: 10,
          quantity: 3,
          category: @category,
        )
      @product.save
      expect(@product.valid?).to be true
    end

    it 'product will not save without a category' do
      @product =
        Product.new(name: 'Harry Potter', price: 10, quantity: 3, category: nil)
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:category]).to include "can't be blank"
    end
  end
end
