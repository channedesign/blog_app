require 'rails_helper'

RSpec.describe 'User Sign Out', type: :feature do 

	before do
		@user = User.create!(email: 'bob@bob.com', password: 'Password1234')
	end

	scenario 'user siging out' do
		visit '/'
		expect(page).not_to have_content('Sign Out')
		click_link "Sign In"

		expect(page.current_path).to eq(new_user_session_path)
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: @user.password
		click_button 'Sign in'

		expect(page.current_path).to eq(root_path)
		expect(page).to have_content(@user.email)
		expect(page).to have_content('Sign Out')
		expect(page).not_to have_content('Sign In')

		click_link('Sign Out')
		expect(page).to have_content('Signed out successfully')
		expect(page.current_path).to eq(root_path)
	end

end