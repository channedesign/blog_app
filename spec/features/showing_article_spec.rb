require 'rails_helper'

RSpec.describe 'Showing Articles', type: :feature do
	
	before do
		@article = Article.create(title: 'Some article', body: 'Some body')
	end

	scenario 'Display individual article' do
		visit '/'

		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
	end

end