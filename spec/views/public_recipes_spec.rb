require 'rails_helper'

RSpec.describe "public_recipes/index.html.erb", type: :view do
  it "displays the header 'Public Recipes'" do
    render

    expect(rendered).to have_selector("h1", text: "Public Recipes")
  end

  context "when @recipes is present" do
    before do
      assign(:recipes, [
        Recipe.new(name: "Recipe 1", user: User.new(name: "User 1"), foods: []),
        Recipe.new(name: "Recipe 2", user: User.new(name: "User 2"), foods: [Food.new(price: 10.5, quantity: 2)])
      ])
    end

    it "displays the recipe name and author for each recipe" do
      render

      expect(rendered).to have_selector("h2", text: "Recipe 1")
      expect(rendered).to have_selector("h4", text: "By User 1")
      expect(rendered).to have_selector("h2", text: "Recipe 2")
      expect(rendered).to have_selector("h4", text: "By User 2")
    end

    it "displays the total food items and total price (if applicable) for each recipe" do
      render

      expect(rendered).to have_selector("h4", text: "Total price: 21.0", count: 1)
    end
  end

  context "when @recipes is empty" do
    before do
      assign(:recipes, [])
    end

    it "displays 'No Public recipes'" do
      render

      expect(rendered).to have_text("No Public recipes")
    end
  end
end