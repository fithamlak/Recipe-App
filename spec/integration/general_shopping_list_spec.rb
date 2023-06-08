require 'rails_helper'

RSpec.describe Recipe, type: :system do
  let(:user) { User.new(name: 'Gerson', email: 'gerson@test.com', password: 'password') }
  subject do
    Recipe.new(user_id: user.id, description: 'description of first recipe', name: 'first recipe', public: true,
               preparation_time: 2.0, cooking_time: 2.0)
  end

  before do
    ActionMailer::Base.deliveries.clear
    user.save
    subject.save
  end

  it 'show the public recipes list' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit general_shopping_list_path
    expect(page).to have_content('Shopping List')
  end
end
