require 'rails_helper'

RSpec.describe 'User Sign In' do
	
	before do
		@user = User.create(email: 'bob@bob.com', password: 'Password1234')
	end

	scenario 'with valid credentials' do
		visit '/'

		click_link 'Sign In'
		expect(page.current_path).to eq(new_user_session_path)

		fill_in 'Email', with: 'bob@bob.com'
		fill_in 'Password', with: 'Password1234'
		click_button 'Sign in'

		expect(page.current_path).to eq(root_path)
		expect(page).to have_content('Signed in successfully')
	end

	scenario 'with invalid credentials' do
		visit '/'

		click_link 'Sign In'
		expect(page.current_path).to eq(new_user_session_path)

		fill_in 'Email', with: 'bob@bob.com'
		fill_in 'Password', with: 'Password'
		click_button 'Sign in'

		expect(page.current_path).to eq(new_user_session_path)
		expect(page).to have_content('Invalid email or password')
	end

end