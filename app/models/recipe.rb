class Recipe < ApplicationRecord
  belongs_to :user
  has_many :foods, through: :recipe_foods
  has_many :recipe_foods
  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :cooking_time, presence: true, comparison: { greater_than: 0 }
  validates :preparation_time, presence: true, comparison: { greater_than: 0 }
end
