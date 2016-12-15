class Recipe < ActiveRecord::Base
  has_many :lists
  has_many :ingredients, through: :lists
  has_many :instructions

  has_and_belongs_to_many :tags

  validates :title, :servings, :rating, :spice, :cook_time, presence: true
  validates :title, uniqueness: true

end
