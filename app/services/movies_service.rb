require 'pry'
require 'faraday'

class MoviesService
  def self.search(input)
    conn = Faraday.new(url: 'https://api.themoviedb.org', params: { api_key: ENV['tmdb_api_key'] })
    response = conn.get("/3/movie/#{input}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.keyword_search(input)
    conn = Faraday.new(url: 'https://api.themoviedb.org', params: { api_key: ENV['tmdb_api_key'] })

    response = conn.get("/3/search/movie", query: input)

    JSON.parse(response.body, symbolize_names: true)
  end

  def cast_list(input)
    conn = Faraday.new(url: 'https://api.themoviedb.org', params: { api_key: ENV['tmdb_api_key'] })

    response = conn.get("/3/movie/#{input}/credits")

    JSON.parse(response.body, symbolize_names: true)
  end

  def reviews(input)
    conn = Faraday.new(url: 'https://api.themoviedb.org', params: { api_key: ENV['tmdb_api_key'] })

    response = conn.get("/3/movie/#{input}/reviews")

    JSON.parse(response.body, symbolize_names: true)
  end
end