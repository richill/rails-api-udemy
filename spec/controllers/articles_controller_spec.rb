require 'rails_helper'
require 'pry'

describe ArticlesController do
  describe '#index' do
    subject { get :index }
    
    it 'should return success response' do 
      subject
      expect(response).to have_http_status(:ok)
      expect(response.status).to eq(200)
    end

    it 'should return proper json' do
      create_list :article, 2 #this creates 2 articles
      subject
      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
          "title"=> article.title,
          "content"=> article.content,
          "slug"=> article.slug
        })
      end
    end

    it 'should return articles in the right order' do
      old_article = create :article
      latest_article = create :article
      subject
      expect(json_data.first['id']).to eq(latest_article.id.to_s)
      expect(json_data.last['id']).to eq(old_article.id.to_s)
    end

    it 'should paginate results' do
      create_list :article, 3 #this creates 3 articles
      get :index, params: { page:2, per_page: 1 }
      expect(json_data.length).to eq 1
      expected_article = Article.recent.second.id.to_s
      expect(json_data.first['id']).to eq(expected_article)
    end
  end

  describe '#show' do
    let(:article) { create :article}
    subject { get :show, params: { id: article.id } }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.status).to eq(200)
    end

    it 'should return proper json' do
      subject

      expect(json_data['attributes']).to eq({
        "title"=> article.title,
        "content"=> article.content,
        "slug"=> article.slug
      })
    end
  end
end
