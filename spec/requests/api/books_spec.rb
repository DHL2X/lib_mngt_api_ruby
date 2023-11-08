require 'rails_helper'

RSpec.describe "Api::Book", type: :request do

  describe "GET /api/book" do

    let(:server) {FactoryBot.create(:server, name: "KR", domain: "kr")}
    before do
      FactoryBot.create(:book, title: "Harry Potter 1", publication_year: 1995, quantity: 3 ,server_id: server.id)
      FactoryBot.create(:book, title: "Harry Potter 1_2", publication_year: 1996, quantity: 2, server_id: server.id )
    end

    it 'has books' do
      get 'http://localhost:4000/api/book'

      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to eq([{"id"=>1,
      "name"=>"Harry Potter 1",
      "year"=>1995,
      "authors"=>"",
      "rented"=>"0 / 3"},
     {"id"=>2,
      "name"=>"Harry Potter 1_2",
      "year"=>1996,
      "authors"=>"",
      "rented"=>"0 / 2"
      }])

      expect(response_body.size).to eq(2) 
    end
  end

  # describe "POST /api/book" do
  # end
end
