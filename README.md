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
- **_FE deployment link needed_**

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

1. Fork and Clone the repo: <a href="https://github.com/Plant-Connect/plant_connect_rails">GitHub - Plant-Connect/plant_connect_rails</a>
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate,seed}`
4. Setup email address and email application security password for the Sidekiq background mailers.
    - <i> *We used a team yahoo account, but you could easily convert to work with Gmail, etc* </i>
5. Setup Heroku for Deployment with the Redis add-on
    - Set-up instructions to deploy a Rails app: <a href= "https://devcenter.heroku.com/articles/getting-started-with-rails5">Heroku - Getting Started With Rails</a>
    - Set-up instructions for Redis add-on: <a href= "https://devcenter.heroku.com/articles/getting-started-with-rails">Heroku Redis</a>
6. Setup Figaro: `bundle exec figaro install`
7. Add environment variables to `config/application.yml`
 - 
    ```
    REDIS_URL: <put_your_key_here>
    REDISTOGO_URL: <put_your_key_here>
    yahoo_user_name: <put_your_key_here>
    yahoo_pw: <put_your_key_here>
    ```
    
<p align="right">(<a href="#top">back to top</a>)</p>

## API Info:
  ### Exposed:
  
- **Get all listings**: 
  - `GET /api/v1/listings`
  - Info:
    - Returns all listings, except listings posted by the currently logged-in user
    - Includes information for the plant that is related to the listing
  - Example Request
     ```
      GET /api/v1/listings?user_id=1
     ```
  - Example Response
    ```
    Status Code: 200
    
    {
      "data": {
          "id": null,
          "type": "listings",
          "attributes": [
              {
                  "listing_id": 16,
                  "active": true,
                  "quantity": 1,
                  "category": "plant",
                  "rooted": true,
                  "plant_id": 16,
                  "user_id": 6,
                  "description": "I am Groot. Sort of....",
                  "plant": {
                      "photo": "https://user-images.githubusercontent.com/91357724/169708737-405f5dc9-42a7-451d-9ba4-17d2346c4b2c.jpeg",
                      "plant_type": "Chia Pet",
                      "indoor": true
                  }
              },
              {
                  "listing_id": 15,
                  "active": true,
                  "quantity": 9,
                  "category": "seeds",
                  "rooted": false,
                  "plant_id": 15,
                  "user_id": 8,
                  "description": "Healing aloe vera seeds",
                  "plant": {
                      "photo": "https://5.imimg.com/data5/IL/VO/JO/ANDROID-66651570/product-jpeg-250x250.jpg",
                      "plant_type": "aloe vera",
                      "indoor": false
                  }
              },
              {
                  "listing_id": 11,
                  "active": true,
                  "quantity": 2,
                  "category": "plant",
                  "rooted": true,
                  "plant_id": 11,
                  "user_id": 11,
                  "description": "So stink, so beautiful. Geraniums",
                  "plant": {
                      "photo": "https://images.pexels.com/photos/10891365/pexels-photo-10891365.jpeg",
                      "plant_type": "geranium",
                      "indoor": false
                  }
              },
              {
                  "listing_id": 9,
                  "active": true,
                  "quantity": 3,
                  "category": "plant",
                  "rooted": true,
                  "plant_id": 9,
                  "user_id": 8,
                  "description": "Fiddle Leaf Fig, Yo",
                  "plant": {
                      "photo": "https://images.pexels.com/photos/6044736/pexels-photo-6044736.jpeg",
                      "plant_type": "fiddle leaf fig",
                      "indoor": true
                  }
              },
              {
                  "listing_id": 6,
                  "active": true,
                  "quantity": 4,
                  "category": "clippings",
                  "rooted": true,
                  "plant_id": 6,
                  "user_id": 6,
                  "description": "Smell it, cook it, whatever.",
                  "plant": {
                      "photo": "https://images.pexels.com/photos/4750370/pexels-photo-4750370.jpeg",
                      "plant_type": "rosemary",
                      "indoor": false
                        }
                    }
                ]
            }
        }
    ```
    
- **Create new listing**: 
  - `POST /api/v1/listings`
  - Info:
    - Creates a new Plant object and creates a Listing for that Plant.
    - Response includes information for the plant and the listing. 
  - Example Request
     ```
      POST /api/v1/listings
      Content-Type: application/json
      Accept: application/json
      Request Body: 
         {
            "user_id": 1,
            "category": 2,
            "description": "I named this Planty McPlantface and it refuses to come when called. Free to a good home.", 
            "quantity": 1,
            "photo": "https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg", 
            "plant_type": "Snake Plant", 
            "indoor": true, 
            "rooted": true,
            "active": true
          }
     ```
  - Example Response
    ```
    Status Code: 201
    
    {
      "data": {
          "id": null,
          "type": "listing",
          "attributes": {
              "listing_id": 20,
              "active": true,
              "quantity": 1,
              "category": "plant",
              "rooted": true,
              "plant_id": 21,
              "description": "I named this Planty McPlantface and it refuses to come when called. Free to a good home.",
              "user_id": 1
          }
        }
      }
    ```
       
- **Update current listing**: 
  - `PATCH /api/v1/listings`
  - Info:
    - Returns newly updated listing information. 
  - Example Request
     ```
      PATCH /api/v1/listings
      Content-Type: application/json
      Accept: application/json
      Request Body: 
         {
          "user_id": 1,
          "listing_id": 20,
          "description": "I named this Planty McPlantface and it refuses to come when called. Free to a GREAT home."
        }
     ```
  - Example Response
    ```
     Status Code: 202
     
     {
      "data": {
          "id": null,
          "type": "listing",
          "attributes": {
              "listing_id": 20,
              "active": true,
              "quantity": 1,
              "category": "plant",
              "rooted": true,
              "plant_id": 20,
              "description": "I named this Planty McPlantface and it refuses to come when called. Free to a GREAT home.",
              "user_id": 1
                }
            }
      }
    ```
       
- **Create new message**: 
  - `POST /api/v1/messages`
  - Info:
    - Creates a new conversation if conversation_id is not provided in POST request. If POST includes conversation_id, new message will be added to existing conversation. 
    - Requires user_id of user sending the message and the listing_id they are messaging. Listing_id is used to find the user_id of the user receiving the message. 
  - Example Request (Without conversation_id included. Creates new conversation and new message.)
     ```
     POST /api/v1/messages
     
     {
      "user_id": 2,
      "listing_id": 1,
      "content": "That's a really nice plant. Can I have it?"
     }
     ```
    - Response
      ```
      Status Code: 201

      {
        "data": {
            "id": "2",
            "type": "message",
            "attributes": {
                "conversation_id": 3,
                "user_id": 2,
                "content": "That's a really nice plant. Can I have it?"
            }
        }
      }
      ```
  - Example Request (With conversation_id included. Creates new message within existing conversation.)
     ```
     POST /api/v1/messages
     
     {
      "user_id": 1,
      "listing_id": 1,
      "content": "Of course you can have it. You'll love Planty!",
      "conversation_id": 3
     }
     ```
    - Response
      ```
      Status Code: 201

      {
        "data": {
            "id": "3",
            "type": "message",
            "attributes": {
                "conversation_id": 3,
                "user_id": 1,
                "content": "Of course you can have it. You'll love Planty!"
            }
          }
      }
      ```
      
- **Get all conversations for a single User**: 
  - `GET /api/v1/conversations`
  - Info:
    - Returns all conversation for the user given. The return will also include all messages for each conversation within a nested hash. 
  - Example Request
     ```
      GET /api/v1/conversations?user_id=1
     ```
  - Example Response
    ```
    Status Code: 200
    
    {
      "data": [
          {
              "id": "2",
              "type": "conversation",
              "attributes": {
                  "messages": [
                      {
                          "id": 1,
                          "content": "I'm very interested in your snake plant.",
                          "user_id": 1,
                          "created_at": "2022-05-23T19:29:17.559Z",
                          "updated_at": "2022-05-23T19:29:17.559Z",
                          "conversation_id": 2
                      }
                  ]
              }
          },
          {
              "id": "3",
              "type": "conversation",
              "attributes": {
                  "messages": [
                      {
                          "id": 2,
                          "content": "That's a really nice plant. Can I have it?",
                          "user_id": 2,
                          "created_at": "2022-05-25T00:16:09.027Z",
                          "updated_at": "2022-05-25T00:16:09.027Z",
                          "conversation_id": 3
                      },
                      {
                          "id": 3,
                          "content": "Of course you can have it. You'll love Planty!",
                          "user_id": 1,
                          "created_at": "2022-05-25T00:22:20.782Z",
                          "updated_at": "2022-05-25T00:22:20.782Z",
                          "conversation_id": 3
                      }
                  ]
              }
          }
      ]
    }
 
    ```
       
- **Get single conversation for a User**: 
  - `GET /api/v1/conversations/<conversation_id>`
  - Info:
    - Returns all messages for a single conversation. 
  - Example Request
     ```
      GET /api/v1/conversations/3?user_id=1
     ```
  - Example Response
    ```
    Status Code: 200
    
    {
      "data": {
          "id": "3",
          "type": "conversation",
          "attributes": {
              "messages": [
                  {
                      "id": 2,
                      "content": "That's a really nice plant. Can I have it?",
                      "user_id": 2,
                      "created_at": "2022-05-25T00:16:09.027Z",
                      "updated_at": "2022-05-25T00:16:09.027Z",
                      "conversation_id": 3
                  },
                  {
                      "id": 3,
                      "content": "Of course you can have it. You'll love Planty!",
                      "user_id": 1,
                      "created_at": "2022-05-25T00:22:20.782Z",
                      "updated_at": "2022-05-25T00:22:20.782Z",
                      "conversation_id": 3
                  }
              ]
          }
      }
    }
    ```   

<p align="right">(<a href="#top">back to top</a>)</p>

## Built With:

- Framework: Ruby on Rails
  - Versions
    - Ruby: 2.7.4
    - Rails: 5.2.7
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
