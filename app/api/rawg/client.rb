module Rawg
  class Client

    def self.games
      response = Request.call('get', '/games')
    end

    def self.game_details(id)
      response = Request.call('get', "/games/#{id}")
    end

    def self.game_posts(id)
      response = Request.call('get', "/games/#{id}/reddit")
    end

    def self.game_trailers(id)
      response = Request.call('get', "/games/#{id}/movies")
    end

    def self.game_stores
      response = Request.call('get', "/stores")
    end
  end
end