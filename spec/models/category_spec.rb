require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    before(:each) do
      @user = User.create(full_name: 'Ian', email: 'ian@gmail.com', password: 'password')
      @category = Category.create(user: @user, name: 'Book', icon: 'image_url')
    end

    it 'name should be present' do
      expect(@category).to be_valid
      @category.name = nil
      expect(@category).to_not be_valid
    end

    it 'icon should be present' do
      expect(@category).to be_valid
      @category.icon = nil
      expect(@category).to_not be_valid
    end

    it 'name must be less or equal than 25 characters' do
      expect(@category).to be_valid
      @category.name = 'a' * 26
      expect(@category).to_not be_valid
      @category.name = 'a' * 25
      expect(@category).to be_valid
    end

    it 'belongs to a user' do
      association = Category.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many transactions' do
      association = Category.reflect_on_association(:expenditures)
      expect(association.macro).to eq(:has_many)
    end
  end
end
