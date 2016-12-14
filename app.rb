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
  if Recipe.create(:title => params['recipe_title'])
    redirect '/'
  else
    erb(:error)
  end
end

get '/recipe/:id' do
  @recipe = Recipe.find(params['id'])
  erb(:recipe)
end
