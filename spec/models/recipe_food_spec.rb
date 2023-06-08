require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
    let(:user) { User.new(name: 'Justice', email: 'just@nels.com', password: 'password') }
    let(:recipe) do
      Recipe.new(user_id: user.id, description: 'description of this recipe', name: 'Recipe 1', public: true,
                 preparation_time: 2.0, cooking_time: 2.0)
    end
    let(:food) { Food.new(user_id: user.id, name: 'kitfo', measurement_unit: 'gm', price: 5, quantity: 5) }
    subject { RecipeFood.new(food_id: food.id, recipe_id: recipe.id, quantity: 2) }
    before do
      user.save
      recipe.save
      food.save
      subject.save
    end
  
    it 'expects recipe food to be invalid when quantity is nil' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
  
    it 'expects recipe food to be invalid when quantity is 0' do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end
  
    it 'expects recipe food to be valid when quantity is present' do
      expect(subject).to be_valid
    end
  end
  