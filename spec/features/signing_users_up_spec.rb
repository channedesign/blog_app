require 'rails_helper'

RSpec.describe 'User Sign Up', type: :feature do 

	scenario 'with valid credentials' do
		visit '/'

		click_link 'Sign Up'
		fill_in 'Email', with: 'bob@bob.com'
		fill_in 'Password', with: 'Password1234'
		fill_in 'Password confirmation', with: 'Password1234'
		click_button 'Sign up'

		expect(page).to have_content('You have signed up successfully.')
		expect(page.current_path).to eq(root_path)
	end

end