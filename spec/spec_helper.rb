ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file}

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
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
  end
end
