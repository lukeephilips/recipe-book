class Ingredient < ActiveRecord::Base
  has_many :lists, dependent: :delete_all
  has_many :recipes
    through: :lists
    dependent: :delete_all
  validates :name, uniqueness: true
end
