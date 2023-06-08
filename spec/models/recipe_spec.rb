require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'Justice', email: 'just@gmail.com', password: 'password') }
  subject do
    Recipe.new(user_id: user.id, description: 'This is my description', name: 'first recipe', public: true,
               preparation_time: 2.0, cooking_time: 2.0)
  end

  before do
    user.save
    subject.save
  end

  it 'expects recipe to be invalid when name is nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be valid when name is present' do
    expect(subject).to be_valid
  end

  it 'expects recipe to be invalid when preparation_time is nil' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be invalid when preparation_time is 0' do
    subject.preparation_time = 0
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be valid when preparation_time is present' do
    expect(subject).to be_valid
  end

  it 'expects recipe to be invalid when cooking_time is nil' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be invalid when cooking_time is 0' do
    subject.cooking_time = 0
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be valid when cooking_time is present' do
    expect(subject).to be_valid
  end

  it 'expects recipe to be invalid when name exceeds the limit of 250 characters' do
    part1 = 'We are testing the maximum length of the name attribute in the recipe model.'
    part2 = 'The name field has a limit of 250 characters, and we want to ensure that when the name exceeds this limit, the recipe object becomes invalid.'
    part3 = 'To do so, we have prepared a lengthy paragraph as an example.'
    part4 = 'This test confirms that the application handles the case when the name attribute exceeds the limit.'
    
    subject.name = part1 + part2 + part3 + part4
    expect(subject).to_not be_valid
  end

  it 'expects recipe to be invalid when description exceeds the limit of 250 characters' do
    part1 = 'We are testing the maximum length of the description attribute in the recipe model.'
    part2 = 'The description field has a limit of 250 characters, and we want to ensure that when the description exceeds this limit, the recipe object becomes invalid.'
    part3 = 'To do so, we have prepared a lengthy paragraph as an example.'
    part4 = 'This test confirms that the application handles the case when the name attribute exceeds the limit.'

    subject.description = part1 + part2 + part3 + part4
    expect(subject).to_not be_valid
  end
end