require 'rails_helper'

describe 'signin', type: :feature do
  before :each do
    User.create(email: 'user@user', username: 'john doe')
  end
  it 'signs @user in' do
    visit '/login'
    fill_in 'email', with: 'user@user'
    click_button 'Login'
    expect(current_path).to eq('/tweets')
  end

  it 'Should not signs @user in if not valid' do
    visit '/login'
    fill_in 'email', with: 'jane doe'
    click_button 'Login'
    expect(current_path).to eq('/login')
    expect(page).to have_text('This user does not exists!!')
  end
end
