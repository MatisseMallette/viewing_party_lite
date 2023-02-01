require 'rails_helper'

RSpec.describe 'user movies index', type: :feature do
  let!(:users) { create_list(:user, 10) }
  let!(:u1) { users.first }


  describe 'happy path' do  
    before :each do 
      visit discover_user_path(u1)
    end

    it 'displays the top 20 movies' do 
      json_response = File.read('spec/fixtures/top_rated_movies.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['tmdb_api_key']}")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.4'
        }
      ).to_return(status: 200, body: json_response, headers: {})

      click_button 'Discover Top Rated Movies'
      expect(current_path).to eq(movies_user_path(u1))
      expect(page).to have_content("The Godfather")
      expect(page).to have_content("Schindler's List")
    end

    it 'displays a movie based on keywords' do 
      json_response = File.read('spec/fixtures/schindler_search.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['tmdb_api_key']}&query=Schindler")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.4'
        }
      ).to_return(status: 200, body: json_response, headers: {})

      fill_in :keyword, with: 'Schindler'
      click_button 'Find Movies'
      expect(current_path).to eq(movies_user_path(u1))
      expect(page).to_not have_content("The Godfather")
      expect(page).to have_content("Schindler's List")
    end
  end

  describe 'sad path' do 

  end
end