class ArticlesController < ApplicationController
  before_action :require_login, only: [:create, :destroy, :edit, :update]
  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.title.present? && @article.body.present?
      @article.save
      flash.notice = "Article '#{@article.title}' was created!"

      redirect_to article_path(@article)
    else
      flash.notice = "Title or body can't be blank!"

      render 'new'
    end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' was deleted!"

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' was updated!"

    redirect_to article_path(@article)
  end
end
