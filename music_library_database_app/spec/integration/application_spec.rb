require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods
  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "should return the HTML content containing a list of albums" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Albums</h1>')
      expect(response.body).to include ('Title: Surfer Rosa')
      expect(response.body).to include ('Released: 1988')
      expect(response.body).to include ('Super Trouper')
      expect(response.body).to include ('1980')
    end
  end
  context "POST /albums" do
    it 'should create a new album' do
      response = post('/albums',
      title: 'Voyage',
      release_year: '2022',
      artist_id: '2')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /artists" do 
    it "should return a list of artists" do
      response = get('/artists')
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
      expect(response.status).to eq(200)
      expect(response.body).to eq expected_response
    end
  end

  context 'POST /artists' do
    it "should create a new artist" do
      response = post('/artists',
      name: 'Wild nothing',
      genre: 'Indie')
      expect(response.status).to eq (200)
      expect(response.body).to eq('')
      response = get('/artists')
      expect(response.body).to include ('Wild nothing')
    end
  end

  context 'GET /albums/:id' do
    it 'should return the HTML content for a single album (2)' do
      response = get('/albums/2')
      expect(response.status).to eq (200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end
end