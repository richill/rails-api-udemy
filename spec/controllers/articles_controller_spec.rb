require 'rails_helper'

describe ArticlesController do
  describe '#index' do
    it 'should return success response' do 
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.status).to ed(200)
    end
  end
end
