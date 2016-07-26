require 'rails_helper'

RSpec.describe 'Adding Comments to Articles', type: :feature do
	
	before do
		@john = User.create(email: 'john@john.com', password: 'Password')
		@bob = User.create(email: 'bob@bob.com', password: 'Password')
		@article = @john.articles.create(title: 'Some title', body: 'some body')
	end

	scenario 'permits a signed in user to write a review' do
		login_as @bob

		visit '/'
		click_link @article.title
		fill_in 'Body', with: 'This is a comment'
		click_button 'Create Comment'

		expect(page).to have_content('Comment has been created')
		expect(page).to have_content('This is a comment')
		expect(page.current_path).to eq(article_path(@article))
	end

end