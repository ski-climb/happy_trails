## Happy Trails

[Production Site](https://pampered-trails.herokuapp.com/)

### Description

The goal of Happy Trails is to empower the community of trail users to log trailwork needs and organzize to work on trails. Guest visitors can see trailwork requests on an interactive map and toggle the requests based on status. Once logged in with Strava, a user can see his/her Strava routes and can add an issue. GPS data for issues is added using metadata from the photos or by dragging a marker to a users desired location. Users can comment on issues and administrators can add work days to automatically email participants with the time, location, and details of the day.

Tech stack: Ruby, Rails, PostgreSQL, Strava API, RSpec, JQuery, S3, Capybara, CarrierWave, Sass

### Dependencies 

This project uses Ruby version 2.3+ with a PostgreSQL database. Images are stored in a S3 bucket. Users are authenticated using Strava Oauth.

### Getting Started

Follow these steps in your terminal to clone the project on to your local machine and import the data.

  1. `cd` into the directory where you want the project in the terminal.
  1. Run `git clone https://github.com/ski-climb/happy_trails.git`
  1. `cd happy_trails` 
  1. `bundle` to install the gems you need
  1. `rake db:create` to create your PostgreSQL database
  1. `rake db:seed` to import stock data

### Test suite

Follow these steps in your terminal to run our test suite and check out the coverage.

  1. `rspec` to run the test suite

### Hosting the site locally

  1. From within the `happy_trails` directory run `rails server` to start the server locally.
  1. In your browser visit http://localhost:3000/
  1. Press `ctrl-c` to stop server.

### Development Challenges

#### Complex Logic in the Issues Controller

One challenged we faced was dealing with all the different logic of creating an issue. A user could enter invalid data, upload a photo with gps metadata, or upload a photo without gps data - and all three cases needed to be handled in a different way. As a result, our issues controller started off looking like this:


To reduce the complexity of these methods we decided to create a photo service and push the logic there. The service then served the purpose of adding the photo to the database and providing us with the correct redirect path and flash message based  the presence of the gps metadata on the photo. After the extraction of the service, the three controller methods above turned into one concise create action in the controller (see below). Checkout out `photo_service.rb` to see the details of how we did it.


#### Toggling Issues by Type on the Map


### API Endpoints


To see all issues visit :`GET /api/v1/models/issues`

To see the polylines for a user's recent Strava routes visit : `GET /api/v1/users/:id/recent_routes`
