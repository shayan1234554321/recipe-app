require 'rails_helper'

RSpec.describe 'Public Recipe Index Page', type: :feature do
  before do
    visit public_recipes_path
  end

  it 'Displays content' do
    expect(page).to have_content('Public Recipes')
  end
end
