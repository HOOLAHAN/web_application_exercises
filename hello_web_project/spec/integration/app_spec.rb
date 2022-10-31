# file: spec/integration/application_spec.rb
require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  context "GET /" do
    it 'returns 200 OK' do
      response = get('/hello?name=Iain')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Iain")
    end
    it 'returns 404 Not Found' do
      response = get('/goodbye')
      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
  context "GET /names" do
    it 'returns a list of names' do
      response = get('/names', names: 'Julia, Mary, Karim')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /submit" do
    it 'returns a message with the correct content' do
      response = post('/submit', name: "Iain", message: 'Nicely done!')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Thanks Iain, you sent this message: Nicely done!")
    end
  end

  context "POST /sorted-names" do
    it 'returns a list of names in alphabetical order' do
      response = post('/sort-names', names: "Joe,Alice,Zoe,Julia,Kieran")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end