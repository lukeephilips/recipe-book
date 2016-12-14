require('spec_helper')

describe(Tag) do

  before do
    @new_tag = Tag.create(:name => 'Vegetarian', :category => 'Diet')
  end

  describe('#recipes') do
    it('adds a recipe with a join to this tag') do
      @new_tag.recipes.create(:title => 'Broccoli Salad', :cook_time => '00:30:00', :servings => 5, :spice => 0, :rating => 1)
      expect(@new_tag.recipes.first.title()).to(eq('Broccoli Salad'))
    end
  end
  describe('#recipes.ingredients') do
    it('adds a recipe with a join to this tag') do
      recp = Recipe.create(:title => 'pasta salad')
      recp.ingredients.create(:name => 'pasta')
      recp.update({:tag_ids => [@new_tag.id]})
      expect(@new_tag.recipes.first.ingredients.first.name()).to(eq('pasta'))
    end
  end
end
