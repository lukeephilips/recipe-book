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

get '/recipe/:id/ingredients/:list_id/delete' do
  @recipe = Recipe.find(params['id'])
  list = List.find(params['list_id'])
  # ingredient = Ingredient.find(list.ingredient_id)
  # ingredient.destroy
  if list.destroy
    redirect "/recipe/#{@recipe.id}/edit"
  else
    erb(:error)
  end
end

get '/recipe/:id/instructions/:instruction_id/edit' do
  # binding.pry
  @recipe = Recipe.find(params['id'])
  @edit_instruction = Instruction.find(params['instruction_id'])
  erb(:edit_instructions)
end

patch '/recipe/:id/instructions/:instruction_id/edit' do
  # binding.pry
  @recipe = Recipe.find(params['id'])
  instruction = Instruction.find(params['instruction_id'])
  instruction.update(:step => params['edit_step'], :description => params['edit_description'])
  redirect "/recipe/#{@recipe.id}/edit"
  erb(:edit_instructions)
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

get '/recipe/:id/edit' do
  @recipe = Recipe.find(params['id'])
  erb(:recipe_form)
end


get '/tag/new' do
  @tags = Tag.all()
  erb(:tag_form)
end

post '/tag/new' do
  name = params['add_tag_name']
  category = params['add_tag_category']
  if Tag.create(:name => name, :category => category)
    @tags = Tag.all()
    redirect '/tag/new'
  else
    erb(:error)
  end
end

delete '/tag/new' do
  if Tag.destroy(params['tag_id'])
    redirect '/tag/new'
  else
    erb(:error)
  end
end

patch '/tag/new' do
  @current_tag = Tag.find(params['tag_id'])
  if @current_tag.update(:name => params['add_tag_name'], :category => params['add_tag_category'])
    redirect '/tag/new'
  else
    erb(:error)
  end
end

get '/tag/edit/:id' do
  @tags = Tag.all()
  @current_tag = Tag.find(params['id'])
  erb(:tag_form)
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
