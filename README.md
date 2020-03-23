AirBnB Listngs API
1. A user pastes a URL of their listing into Rankbreeze. The URL can be in three different formats:

    a.) The usual format: https://www.airbnb.com/rooms/28911341
    
    b.) The abnb shortlink: https://abnb.me/OAlEJ6oqk3
    
    c.) Custom URL: https://airbnb.com/h/stay-less-ordinary
2. The user sees a confirmation of the listing data and decides whether to proceed with saving it or not.
3. If the user decides to click “Save”, we should be able to see that listing on their portfolio page.

If we save the listing, we should also save its target market (for https://www.airbnb.com/rooms/28911341 the target market is Atlanta, Georgia, United States).

To get details of a given Airbnb listing, you can use the following endpoint: https://api.airbnb.com/v2/listings/[[listing_id]]?_format=v1_legacy_short&client_id=#

Please scaffold a new Rails application and setup authentication with the Devise gem and implement the described flow for logged in users. The code you show us should be production-ready.
This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version ruby-2.6.1
* Rails 6
* Node 8.16.0
* Database PostgreSQL

Launch instructions:
- git clone
- bundle install
- rails db:create
- rails db:migrate
- rails webpacker:compile
- create .env like env.example
- rails s
 
*It doesn't work with https://airbnb.com/h/stay-less-ordinary because it send 301 code withoyt content for ID request if request sent not from browser.  