require 'rails_helper'

RSpec.describe 'Editing Articles', type: :feature do
	
	before do
		@user = User.create!(email: 'bob@bob.com', password: 'Password1234')
		@article = Article.create(title: 'first article', body: 'body of first article')
		login_as(@user)
	end

	scenario 'A user edits an article' do
		visit '/'

		click_link @article.title
		click_link 'Edit Article'
		expect(page.current_path).to eq(edit_article_path(@article))
		fill_in 'Title', with: 'first article edited'
		fill_in 'Body', with: 'body edited'
		click_button 'Update Article'

		expect(page).to have_content('Article has been updated')
		expect(page.current_path).to eq(article_path(@article))
	end

	scenario 'A user fails to edit an article' do
		visit '/'

		click_link @article.title
		click_link 'Edit Article'
		expect(page.current_path).to eq(edit_article_path(@article))
		fill_in 'Title', with: ''
		fill_in 'Body', with: 'body edited'
		click_button 'Update Article'

		expect(page).to have_content('Article has not been updated')
		expect(page).to have_content("Title can't be blank")
		expect(page.current_path).to eq(article_path(@article))
	end

end