require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :view do
  describe 'Index page' do
    before(:each) do
      @user = User.new(full_name: 'ian', email: 'ian@gmail.com', password: '123456')
      @user.save
      @category1 = Category.new(user: @user, name: 'Books', icon: 'https://picsum.photos/200/300.webp')
      @category1.save
      @category2 = Category.new(user: @user, name: 'Notebooks', icon: 'https://picsum.photos/200/300.webp')
      @category2.save
      @transaction1 = Expenditure.create(user: @user, name: 'Burger', category: @category1, amount: 'Total Amount: 2.0')
      @transaction2 = Expenditure.create(user: @user, name: 'Fries', category: @category1, amount: 3.0)
      assign(:categories, Category.all)
    end

    before do
      render
    end

    it 'shows the right page' do
      expect(rendered).to have_content('Categories')
    end

    it 'shows a category name' do
      expect(rendered).to have_content('Notebooks')
    end

    it 'displays the correct content' do
      expect(rendered).to have_content(@category1.name)
      expect(rendered).to have_content(@category2.name)
      expect(rendered).to have_content(@transaction1.amount)
      expect(rendered).to have_content(@transaction2.amount)
      expect(rendered).to have_content('Add a new category')
    end
  end
end
