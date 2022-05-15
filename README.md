<div id="top"></div>

# Plant Connect

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li>
      <a href="#api-info">API Info</a>
      <ul>
        <li><a href="#exposed">Exposed</a></li>
        <li><a href="#consumed">Consumed</a></li>
      </ul>
    </li>
    <li><a href="#built-with">Built With</a></li>
    <li>
      <a href="#testing">Testing</a>
      <ul>
        <li><a href="#rspec-test-results">RSpec Test Results</a></li>
      </ul>
    </li>
    <li><a href="#future-additions">Future Additions</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

## About The Project

- **_Project description needed_**
- [Front End Repo](https://github.com/Plant-Connect/plant-connect-FE)
- [Heroku - Back End](https://plant-connect-be.herokuapp.com/)
- **_Heroku FE link needed_**

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

1. Fork and Clone the repo: [GitHub - Plant-Connect/plant_connect_rails](https://github.com/Plant-Connect/plant_connect_rails)
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate}`
4. **_Will there be any API keys needed?_**
5. Setup Figaro: `bundle exec figaro install`
6. Add API keys to `config/application.yml`
 - 
    ```
    <put_environment_variable_name_here>: <put_your_key_here>
    ```
    
<p align="right">(<a href="#top">back to top</a>)</p>

## API Info:
  ### Exposed:
  
- **_Endpoint Name_**: 
  - `**_endpoint goes here_**`
  - Response includes: 
    - **_do we have any images?_**
  - Example Request
     ```
      POST /api/v1/road_trip
      Content-Type: application/json
      Accept: application/json
      Request Body: 
         {
            "origin": "Denver,CO",
            "destination": "Fort Collins,CO",
            "api_key": "6d76a22a274ae6ea30c7b60a11a2c15c"
          }
     ```
  - Example Response
    ```
      {
        "data": {
            "id": "null",
            "type": "roadtrip",
            "attributes": {
                "start_city": "Denver,CO",
                "end_city": "Fort Collins,CO",
                "travel_time": "01:03:57",
                "weather_at_eta": {
                    "temperature": 71.8,
                    "conditions": "clear sky"
                }
            }
        }
      }
    ```
    
    <p align="right">(<a href="#top">back to top</a>)</p>
    

  ### Consumed:
    - _API name?_
      - [_Link to API_](https://openweathermap.org/api/one-call-api)
        - _what was it used for?_

<p align="right">(<a href="#top">back to top</a>)</p>

## Built With:

- Framework: Ruby on Rails
  - Versions
    - Ruby: 2.7.4
    - Rails: 5.2.6
- Database: PostgreSQL
- Deployment: Heroku
- Other tech used:
  - Sidekiq
  - WebSockets 
  - Postman
  - RSpec 

<p align="right">(<a href="#top">back to top</a>)</p>

## Testing:

  - This application is fully tested through RSpec. 
  - You can run RSpec on any directory/file using `bundle exec rspec <directory/file>`
  - SimpleCov is included to ensure tests have full coverage.
  - To run the Simplecov report type the following into your terminal: `open coverage/index.html`
  - See details here: [SimpleCov](https://github.com/simplecov-ruby/simplecov)
  
  ### RSpec Test Results
  
  **_put test screen shots here_**

<p align="right">(<a href="#top">back to top</a>)</p>

## Future Additions

<ol>
  <li>
  </li>
</ol>

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributors

- [Aedan Yturralde](https://github.com/aedanjames)
- [Paul Leonard](https://github.com/pleonar1)
- [Steven James](https://github.com/stevenjames-turing)

<p align="right">(<a href="#top">back to top</a>)</p>
