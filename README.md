# API Wrapper (rawg.io)

This is a excercise project for API Wrappers.

How to create an API Wrapper?

1. Go to https://rawg.io/apidocs and clicked 'Get API Key'. The user will be asked to login or create and account. After logging in, provide the required credentials, including the user's full name, site url, and the description of the app that will use the API. Then, upon submission, the developer(user) info will be displayed together with the API Key. Copy the API key.

2. Go to the project directory. Inside the 'app' folder, create a folder and name it 'api'. All requests or calls from external API's will be put in this folder. 

3. Inside the 'api' folder, create another folder and name it 'rawg'. All requests or calls specific to rawg api will be situated here. Create three folders named 'client.rb', 'request.rb' and 'errors.rb'.

4. Go to 'request.rb' file. Create a module 'Rawg'. This will be used as a namespace identify calls to Rawg outside this module. Inside this module, create a class 'Request'. Inside this class, create constant variables 'API_KEY' and 'BASE_URL'. Set the value of 'API_KEY' to the API key that has been copied from the developer info in https://rawg.io/apidocs. Also, set the value of ;BASE_URL' to 'https://api.rawg.io/api'.

5. Still inside the class 'Request', create a method named 'self.call'. This method will contain the request calls to rawg api thru REST Client. REST Client is the service app directly invoking the Rawg API. To install this, go to Gemfile and add "gem 'rest-client', '~> 2.1'". Then run bundle install on the console. After installation, rest-client methods can now be used.




