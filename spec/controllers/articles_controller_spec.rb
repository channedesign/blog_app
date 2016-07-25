require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do

  	before do
  		@john = User.create!(email: 'john@john.com', password: 'Password1234')
  	end

  	context 'Owner is allowed to edit his articles' do
  		it 'renders the edit template' do
  			login_user @john
  			article = @john.articles.create(title: 'first article', body: 'body of first article')

  			get :edit, id: article.id
  			expect(response).to render_template :edit
  		end
  	end

  	context 'Non onwner is not allowed to edit other users articles' do
  		it 'redirect to  the root path' do
  			bob = User.create(email: 'bob@bob.com', password: 'Password1234')
  			article = @john.articles.create(title: 'Johns article', body: 'John body article')

  			login_user bob
  			get :edit, id: article.id
  			expect(response).to redirect_to(root_path)
  			msg = 'You can only edit your own article'
  			expect(flash[:danger]).to eq msg
  		end
  	end

  end

end
