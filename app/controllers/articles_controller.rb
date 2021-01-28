class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.recent.page(params[:page]).per(params[:per_page])
    render json: @articles
  end

  def show
    render json: @article
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end
end
