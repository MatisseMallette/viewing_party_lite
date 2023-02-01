require './app/services/movies_service'

class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:id])
    data =  if params[:q] == 'top_rated' 
              MoviesService.search(params[:q])
            else
              MoviesService.keyword_search(params[:keyword])
            end

    @movies = data[:results][0..19].pluck(:original_title, :id, :vote_average)
  end
end