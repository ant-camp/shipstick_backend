# ShipSticks Coding Challenge - Backend

# Getting Started

* Using ruby 2.7.3
* Using Rails 6.1.4

* `bundle install`
* `rails s -p 3001` - `localhost:3001`

# Populate DB
* To populate our DB from `product.json` - `bundle exec rake products:populate `

# Running Tests
* To run all tests - `bundle exec rspec` or `rspec`

# Postman sample API requests
* postman - https://easyupload.io/02c49a

# Additional info
* Please check the `mongoid.yaml` and configure it to your env. - Due to my personal machine being out of memory i couldn't download Mongodb locally so i used - MongoDB Atlas & MongoDB Compass to get my DB running locally - so running specs and validations were spotty 