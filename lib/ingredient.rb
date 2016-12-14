class Ingredient < ActiveRecord::Base
  has_many :lists
  has_many :recipes, through: :lists

end
