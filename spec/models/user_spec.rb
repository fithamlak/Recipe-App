require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Justice', email: 'just@nels.com', password: 'password') }

  before { subject.save }

  it 'expects user to be invalid when name is empty' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'expects user to be valid when name is not empty' do
    expect(subject).to be_valid
  end

  it 'expects user to be invalid when email is nil' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'expects user to be valid when email is not nil' do
    expect(subject).to be_valid
  end
end
