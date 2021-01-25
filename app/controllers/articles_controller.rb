class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.recent 
    render json: @articles
  end

  def show
  end
end
