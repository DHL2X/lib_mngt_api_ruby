# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'User Authentication', type: :request do
  describe 'POST /login' do
    let(:server) {FactoryBot.create(:server, name:"KR", domain:"kr")}
    let(:user) {FactoryBot.create(:user, email: 'user2@example.com', password: 'password', server: server)}

    it 'Login user and logout' do
      post 'http://localhost:4000/login', params: { 
        user: {
          email: user.email, 
          password: user.password
        }
      }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(response.headers['Authorization']).not_to be_nil
      @token = response.headers['Authorization']

      delete 'http://localhost:4000/logout', headers: {'Authorization': @token}
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to eq({
        "status" => 200,
        "message" => "logged out successfully"
      })
    end
  end
end
