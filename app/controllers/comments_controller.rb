class CommentsController < ApplicationController

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.new(comment_params)
		@comment.user = current_user

		if @comment.save
			flash[:success] = "Comment has been created"
		else
			flash[:danger] = "Comment has not been created"
		end
		redirect_to article_path(@article)
	end

	private
		def comment_params
			params.require(:comment).permit(:body, :user_id, :article_id)
		end

end