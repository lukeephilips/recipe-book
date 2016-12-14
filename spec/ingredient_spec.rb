require('spec_helper')

describe(Ingredient) do

  before do
    @new_ingredient = Ingredient.create(:name => 'broccoli', :food_group => 'vegetable')
    @new_ingredient_2 = Ingredient.create(:name => 'carrot', :food_group => 'vegetable')
    @new_recipe = Recipe.create(:title => 'Broccoli Salad', :cook_time => '00:30:00', :servings => 5, :spice => 0, :rating => 1)
  end

  describe('#recipes') do
    it('returns a list of ingredients in a recipes with this ingredient') do
      @new_ingredient.update({:recipe_ids => [@new_recipe.id()]})
      @new_ingredient_2.update({:recipe_ids => [@new_recipe.id()]})
      expect(@new_recipe.ingredients()).to(eq([@new_ingredient, @new_ingredient_2]))
    end
    it('returns all recipes an ingredient is in if another is added') do
      @new_ingredient.update({:recipe_ids => [@new_recipe.id()]})
      another_recipe = Recipe.create(:title => 'pasta primavera')
      @new_ingredient.recipes.push(another_recipe)
      expect(@new_ingredient.recipes).to(eq([@new_recipe, another_recipe]))
    end
  end
end
