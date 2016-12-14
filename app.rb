require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

get '/' do
  @recipes = Recipe.all
  erb(:index)
end

get '/recipe/new' do
  erb(:recipe_form)
end

post '/recipe/new' do
  if @recipe = Recipe.create(:title => params['recipe_title'],:servings => params['servings'], :rating => params['rating'], :spice => params['spice'],:cook_time => params['cook_time'])
    erb(:recipe_form)
  else
    erb(:error)
  end
end

post '/recipe/:id/ingredients/new' do
  ingredient = Ingredient.create(:name => params['add_ingredient'], :food_group => params['add_food_group'])
  @recipe = Recipe.find(params['id'])
  List.create(:recipe_id => @recipe.id, :ingredient_id => ingredient.id, :amount => params['add_amount'], :unit => params['add_units'])
  erb(:recipe_form)
end

post '/recipe/:id/instructions/new' do
  @recipe = Recipe.find(params['id'])
  @recipe.instructions.create(:step => params['add_step'], :description => params['add_description'])
  erb(:recipe_form)
end

get '/recipe/:id' do
  @recipe = Recipe.find(params['id'])
  erb(:recipe)
end

get '/clear' do
  Ingredient.all.each() do |ingredient|
    ingredient.destroy()
  end
  Recipe.all.each() do |recipe|
    recipe.destroy()
  end
  List.all.each() do |list|
    list.destroy()
  end
  Tag.all.each() do |tag|
    tag.destroy()
  end
  @recipes = Recipe.all
  erb(:index)
end
