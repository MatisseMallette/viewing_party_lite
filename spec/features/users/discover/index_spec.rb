require 'rails_helper'

RSpec.describe 'user discover index', type: :feature do
  let!(:users) { create_list(:user, 10) }
  let!(:u1) { users.first }


  describe 'happy path' do  
    before :each do 
      visit discover_user_path(u1)
    end

    it 'has button to view top rated movies' do 
      expect(page).to have_button('Discover Top Rated Movies')
    end

    it 'has field to search for movies by title' do 
      expect(page).to have_field(:title)
      expect(page).to have_button('Find Movies')
    end
  end

  describe 'sad path' do 

  end
end