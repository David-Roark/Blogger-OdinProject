class CommentsController < ApplicationController
  before_action :require_login, only: [:create]
  include CommentsHelper

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @article = Article.find(params[:article_id])

    if @comment.author_name.present? && @comment.body.present?
      @comment.save

      redirect_to article_path(@comment.article_id)
    else
      flash.notice = "Your name or your comment can't be blank!"

      render 'articles/show'
    end
  end
end
