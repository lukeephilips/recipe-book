require('spec_helper')

describe(Recipe) do

  before do
    @new_recipe = Recipe.create(:title => 'Broccoli Salad', :cook_time => '00:30:00', :servings => 5, :spice => 0, :rating => 1)
  end


  describe('#save') do
    it('checks to see if all attributes are submitted') do
      test_recipe = Recipe.new()
      expect(test_recipe.save()).to(eq(false))

    end
  end
end
