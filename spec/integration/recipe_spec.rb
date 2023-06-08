require 'rails_helper'

RSpec.describe Recipe, type: :system do
  let(:user) { User.new(name: 'Justice', email: 'just@test.com', password: 'password') }
  subject do
    Recipe.new(user_id: user.id, description: 'description of the recipe', name: 'first recipe', public: true,
               preparation_time: 2.0, cooking_time: 2.0)
  end

  before do
    ActionMailer::Base.deliveries.clear
    user.save
    subject.save
  end

  # INDEX Recipes PAGE CAPYBARA
  it 'show the recipes list' do
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
    visit recipes_path
    expect(page).to have_content(subject.name)
  end

  # New Recipes PAGE CAPYBARA
  it 'create recipe path' do
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

    visit recipes_path

    click_button 'Add Recipe'

    expect(page).to have_current_path(new_recipe_path)
  end

  # Show Recipes PAGE CAPYBARA
  it 'Navigate to especific recipe path' do
    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]
    visit path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit recipes_path(subject.id)

    expect(page).to have_content(subject.name)
  end
end
