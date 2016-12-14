require('spec_helper')

describe(Instruction) do

  before do
    @new_recipe = Recipe.create(:title => 'Broccoli Salad', :cook_time => '00:30:00', :servings => 5, :spice => 0, :rating => 1)
  end

  describe('#instructions.create') do
    it('creates an instruction object throuch a recipe') do
      ins = [[1, "turn on the oven"], [2, "put thing in oven"],[3, "bake thing"],[4, 'take thing out of oven']]
      ins.each do |i|
        @new_recipe.instructions.create(:step => i[0], :description => i[1])
      end
      expect(@new_recipe.instructions.count).to(eq(4))
    end
  end
end
