require 'rails_helper'

RSpec.describe 'recipe details', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(name: 'Nick', email: 'nick@example.com', password: '123456', password_confirmation: '123456')
  end
  let!(:recipe) do
    Recipe.create(name: 'Test', preparation_time: '1 hr', cooking_time: '1 hr', description: 'Test', public: true,
                  user_id: user.id)
  end

  before(:each) do
    sign_in user
  end

  describe 'show page' do
    before { visit recipe_path(recipe) }

    it 'displays the recipe name' do
      expect(page).to have_content(recipe.name)
    end

    it 'displays the recipe description' do
      expect(page).to have_content(recipe.description)
    end

    it 'displays the recipe preparation time' do
      expect(page).to have_content(recipe.preparation_time)
    end

    it 'displays the recipe cooking time' do
      expect(page).to have_content(recipe.cooking_time)
    end

    it 'displays a button to generate shopping list' do
      expect(page).to have_button('Generate Shopping List')
    end

    it 'displays a form to add a new ingredient' do
      expect(page).to have_selector('form')
    end
  end

  describe 'new page' do
    before { visit new_recipe_path }

    it 'displays the title "New Recipe"' do
      expect(page).to have_content('New Recipe')
    end

    it 'displays a form to create a new recipe' do
      expect(page).to have_selector('form')
    end

    it 'should display the following fields: name, description, preparation time, cooking time, public' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Preparation time')
      expect(page).to have_field('Cooking time')
      expect(page).to have_field('Public')
    end
  end
end
