require 'rails_helper'

RSpec.describe 'Deleting Articles', type: :feature do
	
	before do
		@article = Article.create(title: 'Some title', body: 'some body')
	end

	scenario 'A user deletes an article' do
		visit '/'

		click_link @article.title
		expect(page.current_path).to eq(article_path(@article))

		click_link 'Delete Article'
		expect(page).to have_content('Article has been deleted')
		expect(page).not_to have_content(@article.title)
		expect(page.current_path).to eq(root_path)
	end

end