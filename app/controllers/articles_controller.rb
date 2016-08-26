class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new 
    @article = Article.new

  end

  def edit
  end

  def create 
    debugger
    @article = Article.new(article_params)
    @article.user = User.last
    if @article.save
      flash[:success] = "Articel was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @article.user = User.last
    if @article.update (article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  
  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end