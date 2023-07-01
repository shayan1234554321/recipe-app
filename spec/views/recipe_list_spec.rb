require 'rails_helper'

RSpec.describe 'recipe list', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create(name: 'Nick', email: 'nick@example.com', password: '123456', password_confirmation: '123456')
  end
  let!(:recipe) do
    Recipe.create(name: 'Test', preparation_time: '1 hr', cooking_time: '1 hr', description: 'Test', public: true,
                  user_id: user.id)
  end

  describe 'index page' do
    context 'as a logged-in user' do
      before do
        sign_in user
        visit recipes_path
      end

      it 'should display the title "Recipes"' do
        expect(page).to have_content('Recipes')
      end

      it 'should display a link to create a new recipe' do
        expect(page).to have_link('Add new recipe', href: new_recipe_path)
      end

      it 'should display each recipe name and description' do
        expect(page).to have_content(recipe.name)
        expect(page).to have_content(recipe.description)
      end

      it 'should display a link to delete each recipe' do
        expect(page).to have_content('Delete')
      end
    end

    context 'as a guest user' do
      before do
        visit recipes_path
      end

      it 'should display the title "Recipes"' do
        expect(page).to have_content('Recipes')
      end

      it 'should not display a link to create a new recipe' do
        expect(page).not_to have_link('New Recipe', href: new_recipe_path)
      end

      it 'should not display each recipe name and description' do
        expect(page).not_to have_content(recipe.name)
        expect(page).not_to have_content(recipe.description)
      end

      it 'should not display a link to delete each recipe' do
        expect(page).not_to have_link('Remove', href: recipe_path(recipe))
      end
    end
  end
end
