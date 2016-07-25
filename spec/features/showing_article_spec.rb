require 'rails_helper'

RSpec.describe 'Showing Articles', type: :feature do
	
	before do
		@user = User.create(email: 'bob@bob.com', password: 'Password1234')
		@user2 = User.create(email: 'aaa@aaa.com', password: 'Password1234')
		@article = @user.articles.create(title: 'Some article', body: 'Some body')
	end

	scenario 'A non-signed in user does not see Edit or Delete links' do
		visit '/'
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
		expect(page).not_to have_link('Edit Article')
		expect(page).not_to have_link('Delete Article')
	end

	scenario 'A non-owner signed in user does not see Edit or Delete links' do
		login_as(@user2)
		visit '/'
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
		expect(page).not_to have_link('Edit Article')
		expect(page).not_to have_link('Delete Article')
	end

	scenario 'A signed in owner sees both links' do
		login_as(@user)
		visit '/'
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
		expect(page).to have_link('Edit Article')
		expect(page).to have_link('Delete Article')
	end

	scenario 'Display individual article' do
		visit '/'

		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
	end

end