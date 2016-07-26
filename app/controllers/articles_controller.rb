class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_id, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @comments = @article.comments.new
  end

  def new
  	@article = Article.new
  end

  def create
  	@article = current_user.articles.new(article_params)

  	if @article.save
  		flash[:success] = "Article has been created"
  		redirect_to articles_path
  	else
      flash.now[:danger] = "Article has not been created"
  		render :new
  	end
  end

  def edit
    if @article.user != current_user
      deny_access
    end
  end

  def update
    if @article.user != current_user
      deny_access
    else
      if @article.update(article_params)
        flash[:success] = 'Article has been updated'
        redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to root_path
    end
  end

  private
  	def article_params
  		params.require(:article).permit(:title, :body)
  	end

    def find_id
      @article = Article.find(params[:id])
    end
    def deny_access
      flash[:danger] = 'You can only edit your own article'
      redirect_to root_path
    end
end
