## Happy Trails

[Production Site](https://pampered-trails.herokuapp.com/)

### Description

Nick Erhardt and Kyle Heppenstall created Happy Trails to empower the community of trail users to log trailwork needs and organzize to work on trails. Guest visitors can see trailwork requests on an interactive map and toggle the requests based on status. Once logged in with Strava, a user can see his/her Strava routes and can add an issue. GPS data for issues is added using metadata from the photos or by dragging a marker to a user's desired location. Users can comment on issues and administrators can add work days to automatically email participants with the time, location, and details of the day.

Developers: [Kyle Heppenstall](https://www.turing.io/alumni/kyle-heppenstall), [Nick Erhardt](https://www.turing.io/alumni/nicholas-erhardt)

### Technology

Tech stack: Ruby, Rails, PostgreSQL, Mapbox API, Strava API, Travis CI, Redis, Sidekiq, Skylight, Heroku, RSpec, JQuery, AWS (S3), Capybara, CarrierWave, Sass

* Ruby on Rails application backed by a PostgreSQL database and deployed on Heroku
* Maps pulled in from Mapbox
* OAuth with Strava and display a user's routes with Strava API
* Travis CI for continuous integration
* Tested with RSpec and Capybara
* Images uploaded using Carrierwave and stored on AWS using a S3 bucket
* Background worker for sending emails using Redis Server and Sidekiq
* Skylight used for performance monitoring
* Pins for each issue loaded on the map using an Ajax call to our internal API and added to the map using JQuery

### Getting Started

Follow these steps in your terminal to clone the project on to your local machine and import the data.

  1. `cd` into the directory where you want the project in the terminal.
  1. Run `git clone https://github.com/ski-climb/happy_trails.git`
  1. `cd happy_trails` 
  1. `bundle` to install the gems you need
  1. `rake db:create` to create your PostgreSQL database
  1. `rake db:schema:load` to load the database schema
  1. `rake db:seed` to import stock data

### Test suite

Follow these steps in your terminal to run our test suite and check out the coverage.

  1. `rspec` to run the test suite

### Hosting the site locally

  1. From within the `happy_trails` directory run `rails server` to start the server locally.
  1. In your browser visit http://localhost:3000/
  1. Press `ctrl-c` to stop server.

### Technical Challenges

#### Complex Logic in the Issues Controller

One challenged we faced was dealing with all the different logic of creating an issue. A user could enter invalid data, upload a photo with gps metadata, or upload a photo without gps data - and all three cases needed to be handled in a different way. As a result, our issues controller started off looking like this:

![Sloppy Issues Controller](https://cloud.githubusercontent.com/assets/16868275/23441507/01ed8380-fde0-11e6-87cf-163e890e5239.png)

To reduce the complexity of these methods we decided to create a photo service and push the logic there. The service then served the purpose of adding the photo to the database and providing us with the correct redirect path and flash message based  the presence of the gps metadata on the photo. After the extraction of the service, the three controller methods above turned into one concise create action in the controller:

![Cleaner Issues Controller](https://cloud.githubusercontent.com/assets/16868275/23441767/991f4350-fde1-11e6-928e-6a03d0a1d957.png)

![Photo Service](https://cloud.githubusercontent.com/assets/16868275/23441813/e460ac6e-fde1-11e6-99ae-d5e349edf1a2.png)

#### Displaying a User's most recent Strava Routes

One fascinating aspect of this project was learning how to retrieve and plot the user's Strava routes on the map.

The process went a little like this: user logs in (via Strava), the application loads the map on the client side and then makes an AJAX request back to the application server.  The server in turn queries  Strava's API to get the user's most recent routes.  Part of the response from Strava includes polylines of the routes.

A polyline is a string representation of a number of paired lat/lon coordinates which have been encoded and looks like this: *_p~iF~ps|U_ulLnnqC_mqNvxq@*.  No, the dog did not just walk across my keyboard.  The above polyline can represent a complex path via a series of lat/lon coordinates but is comprised of fewer characters than this sentence - which makes it a convenient way to pass GPS data from our server to the client's browser.

Once the browser has a list of polylines, we decode the polyline back into paired lat/lon points and plot those points to form a line on the map.

What could be simpler.

To refresh, the browser makes an AJAX call to our application server, which then queries the Strava API, which returns the most recent routes for the user (including polyline data), which is passed back to the user's browser, which is decoded from a polyline to lat/lon coordinates, which are then plotted on the map to display the routes.

This is what the routes look like once added to the map:
![Strava Routes](https://cloud.githubusercontent.com/assets/19230981/23526382/163524ea-ff4f-11e6-8369-326a7150959c.png)

### API Endpoints

To render issues or Strava routes on the map we hit our own API with AJAX requests. The two endpoints we created are detailed here:

* To see all issues visit :`GET /api/v1/models/issues`
* To see the polylines for a user's recent Strava routes visit : `GET /api/v1/users/:id/recent_routes`
