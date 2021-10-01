module Api
  class GamesController < ApplicationController
    
    def index
      games = Rawg::Client.games

      render json: games
    end

    def details
      game = Rawg::Client.game_details(params[:id])

      render json: game
    end

    def posts
      posts = Rawg::Client.game_posts(params[:id])

      render json: posts
    end

    def trailers
      trailers = Rawg::Client.game_trailers(params[:id])

      render json: trailers
    end

    def stores
      stores = Rawg::Client.game_stores

      render json: stores
    end
  end
end