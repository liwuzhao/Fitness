class Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :admin_required
  layout "admin"

  # ---CRUD---

  def index
    @articles = Article.all.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to admin_articles_path
    else
      redirect_to :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
      redirect_to admin_articles_path
  end

  # ---private---

  def article_params
    params.require(:article).permit(:image, :title, :description, :user_id, :is_hidden)
  end

end
