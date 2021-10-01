# API Wrappers (rawg.io)

This is a practice project for API Wrappers.

#### How to set up the files?

1. Go to `https://rawg.io/apidocs` and click 'Get API Key'. The user will be asked to login or create and account. After logging in, provide the required credentials, including the user's full name, site url, and the description of the app that will use the API. Then, upon submission, the developer(user) info will be displayed together with the API Key. Copy the API key.

2. Go to the project directory. Inside the 'app' folder, create a folder and name it `api`. All requests or calls to/from external API's will be put in this folder. 

3. Inside the `api` folder, create another folder and name it `rawg`. All requests or calls specific to rawg api will be situated here. Create three folders named `client.rb`, 'request.rb' and 'errors.rb'.

4. Go to `request.rb` file. Create a module `Rawg`. This will be used as a namespace to identify calls to Rawg outside this module. Inside this module, create a class `Request`. The method under the class `Request` will contain the request calls to rawg api thru REST Client. REST Client is the service app directly invoking the Rawg API. To install this, go to Gemfile and add "gem 'rest-client', '~> 2.1'". Then run bundle install on the console. After installation, rest-client methods can now be used.



#### Set up for class `Request` inside `request.rb`

Inside this class, create constant variables `API_KEY` and `BASE_URL`. Set the value of `API_KEY` to the API key that has been copied from the developer info in `https://rawg.io/apidocs`. Also, set the value of `BASE_URL` to `'https://api.rawg.io/api'`.

Create a method named `self.call` which will accept two arguments, `http_method` and `endpoint`. For rawg, it accepts only `get` as http_method.
```
module Rawg
  class Request
    API_KEY =  <YOUR API KEY>
    BASE_URL = 'https://api.rawg.io/api'
    
    def self.call(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}?key=#{API_KEY}",
        headers: { 'Content-Type' => 'application/json' }
      )

      { code: result.code, status: 'Success', data: JSON.parse(result.body) }
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code) }
    end
  end
end
 ```
#### Rawg endpoints utilized for this project.
 1. `/games` - returns list of games
 2. `/games/#{id}` - returns game details with ID or a slug identifying the game as the value for parameter `id`
 3. `/games/#{id}/reddit` - returns a list of most recent posts with ID or a slug identifying the game as the value for parameter `id`
 4. `/games/#{id}/movies` - returns a list of trailers with ID or a slug identifying the game as the value for parameter `id`
 5. `/stores` - returns a list of videogame store fronts.


If the request is successful, `{ code: result.code, status: 'Success', data: JSON.parse(result.body) }` will be returned with the data containing the value returned by the API endpoint. Otherwise, the request will be rescued by `RestClient::ExceptionWithResponse => error` which returns `{ code: error.http_code, status: error.message, data: Errors.map(error.http_code) }`. The data attribute for the latter is mapped from the class `Errors` inside `errors.rb`.



#### Here is the code inside `client.rb`
Each method here is calling the Request class method `call` which accepts two arguments namely`http_method` and `endpoint` as stated above and returns objects specific for each endpoints.
```
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
```

#### Here is the code inside `errors.rb`
```
module Rawg
  class Errors
    def self.map(code)
      case code
      when 401
        return 'Unauthorized request. Please try again'
      when 404
        return 'Invalid Request!'
      else
        return 'Service Unavailable. Please try again.'
      end
    end
  end
end
```

#### Utilizing the wrapper inside controllers.
Example: Get list of games

To get the list of games, create a method index inside the games (or any) controller. Then inside this method, call `Rawg::Client.games`. The method `games` can be found inside th module `Rawg`, class `Client` from the `client.rb` file. Explicitly call the render method and pass the key-value pair `json: games` so when the controller method is called, it will return the object `games` in `json format`.
```
    def index
      games = Rawg::Client.games

      render json: games
    end
```
 


