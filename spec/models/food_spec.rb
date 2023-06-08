require 'rails_helper'

RSpec.describe Food, type: :model do
    let(:user) { User.new(name: 'Justice', email: 'just@nels.com', password: 'password') }
    subject { Food.new(user_id: user.id, name: 'kitfo', measurement_unit: 'gm', price: 5, quantity: 5) }
    before do
      user.save
      subject.save
    end
  
    it 'expects food to be invalid when quantity is nil' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
  
    it 'expects food to be invalid when quantity is 0' do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end
  
    it 'expects food to be valid when quantity is not nil' do
      expect(subject).to be_valid
    end
  
    it 'expects food to be invalid when price is nil' do
      subject.price = nil
      expect(subject).to_not be_valid
    end
  
    it 'expects food to be invalid when price is 0' do
      subject.price = 0
      expect(subject).to_not be_valid
    end
  
    it 'expects food to be valid when price is not nil' do
      expect(subject).to be_valid
    end
  
    it 'expects food to be invalid when name exceeds the limit of 250 characters' do
      part1 = 'We are testing the maximum length of the name attribute in the Food model.'
      part2 = 'The name field has a limit of 250 characters, and we want to ensure that when the name exceeds this limit, the food object becomes invalid.'
      part3 = 'To do so, we have prepared a lengthy paragraph as an example.'
      part4 = 'This test confirms that the application handles the case when the name attribute exceeds the limit.'
      subject.name = part1 + part2 + part3 + part4
      expect(subject).to_not be_valid
  end
  
  
  
    it 'expects food to be invalid when measurement_unit exceeds the limit 250 characters' do
      part1 = 'We are testing the maximum length of the measurement_unit attribute in the Food model.'
      part2 = 'The measurement_unit field has a limit of 250 characters, and we want to ensure that when the measurement_unit'
      part3 = 'exceeds this limit, the food object becomes invalid.To do so, we have prepared a lengthy paragraph as an example.'
      part4 = 'This test confirms that the application handles the case when the measurement_unit attribute exceeds the limit.'
  
      subject.measurement_unit = part1 + part2 + part3 + part4
      expect(subject).to_not be_valid
    end
  end