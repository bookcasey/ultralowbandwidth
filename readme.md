# Ultra Low Bandwidth
## A Fun Thing for Useful, Microscopic Data

Visit [www.ultralowbandwidth.com](http://www.ultralowbandwidth.com/) or [ulb.io](http://www.ulb.io)

### Install

Clone this badboy down, climb in that directory, and get your gems in order with `bundle install`

Make sure to set the API keys locally (with bash, for the current shell each time you want to (crumby, I know—working on it!)):

    export FORECAST_KEY=...

And then run it: `shotgun app.rb`, and lisit `localhost:9393` (probably) in your browser.

### Heroku

Push to heroku with git as normal, then set:

    heroku config:set FORECAST_KEY="...""