class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.recent.page(params[:page]).per(params[:per_page])
    render json: @articles
  end

  def show
  end
end
