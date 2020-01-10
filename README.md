# Historical Cities 

This is a Ruby on Rails app based on the Urban Spatial Data from 3700BC to 2000AD found at https://sedac.ciesin.columbia.edu/data/set/urbanspatial-hist-urban-pop-3700bc-ad2000 The spreadsheet needed to be imported into the app, and https://spin.atomicobject.com/2017/03/22/parsing-excel-files-ruby/ provides a comparative guide to parsing Excel files with different gems. This uses the Creek gem to import the spreadsheet using rake. https://github.com/pythonicrubyist/creek as it provides fast importing of large datasets.

## See me running
You'll find the current version of the app running on Heroku at http://fathomless-scrubland-43773.herokuapp.com Given the restrictions there this will be a reduced dataset to stay under 10k records in the database. One noticable difference in working so closely with Postgresql on this app, is that PG is much fussier about queries than sqlite3, which is being run locally. In particular, the table column names needed to be changed as they all start with capitals, which is not allowed in PG. This rendered some queries impossible.

## Rails 6
This project is also a chance to explore Rails 6, and it's changes. There will be notes here about what's working and which guides have been useful for me and this project. This will become part of the course I teach on Ruby and Rails at the University of Aberdeen. The practicals and 'deliberate practice' sessions can be found at https://homepages.abdn.ac.uk/b.scharlau/pages/rails-pages/ 

These guides to Rails 6 seems to have some useful pointers
https://dev.to/vvo/a-rails-6-setup-guide-for-2019-and-2020-hf5 
https://medium.com/@adrian_teh/ruby-on-rails-6-with-webpacker-and-bootstrap-step-by-step-guide-41b52ef4081f 

## Webpacker
We'll use Webpack with Bootstrap following this guide on Medium https://medium.com/@guilhermepejon/how-to-install-bootstrap-4-3-in-a-rails-6-app-using-webpack-9eae7a6e2832 so that the pages look better and we have a working example to style things a little bit by working through bootstrap basics at https://getbootstrap.com/docs/4.3/getting-started/introduction/ to remove tables and add other suitable styling. 

The goal is to explore how we might use this dataset to develop increasingly better versions of a web application. There are 10300+ records in the dataset.
For all of these we use the 'will_paginate' gem at https://github.com/mislav/will_paginate for pagination.

## Charts
Highcharts are used for generating charts
see instructions at bottom of the page at
https://homepages.abdn.ac.uk/b.scharlau/pages/practical-three-adding-models-to-the-travel-agent/ 
Putting the formatting together to work for the chart of populations was more challenging than expected. Webpacker worked fine. The challenge was how to do 'dates' or 'years', and ended up with a simplier solution than expected. Given we want to put different dates and populations on the chart it's best to treat the years as 'categories' for Highcharts, the same as apples, oranges, and pears. This lets us pass in any array of values without any trouble.

## Maps
This uses Leaflet for mapping https://leafletjs.com as it's lightweight and there are no licence issues to worry about as it's built on top of Open Street Map. This proven a pain using yarn and npm for install, and needed to move images to sit under javascript/stylesheets/images, which is not where I expected. Basics are there, but issue with map icons being called from leaflet CSS.

Leaflet did not work with Webpacker. All leaflet files needed to be removed and the 'unpkg.com' solution used as mentioned in the 'quick start tutorial. While map tiles could be displayed, Webpacker added an extra few characters to the url so it ended up as .png%22 for the CSS icons. By using the online versions, it all works.

You can change map provider via details at http://leaflet-extras.github.io/leaflet-providers/preview/ 

## Racing Barchart Experiment
The goal is to create a racing barchart showing the rise and fall of city populations over time. There are lots of examples that use the [Flourish bar chart race guide](https://app.flourish.studio/@flourish/bar-chart-race#guide). This makes it clear the data needs to be in the right format in order for this work. This led to an exploration of 'what should the data look like'? I realised that I needed to generate my own JSON file, and that Flourish wasn't necessary.

### Move to Postgresql Locally
While generating JSON the SQL language differences between SQLite3 and Postgresql made it necessary to shift local development to Postgresql. Making changes, and then pushing them to Heroku takes too long (4-5 minutes each cycle due to recompiling of assets), so running Postgresql locally is important.
In order to do this with Postgresql, you need to (a) set up a database to use, (b) assign an 'owner' and password for the database, whose details you put into the config/database.yml file, then you can (c) run your migrations and any rake tasks to seed the database, (d) change the gemfile to use 'pg' gem for development, test, and production and then run 'bundle install'. Now you can start to work with Postgresql locally and remotely. 

If you're new to Postgresql, then these links should help you:
Remember to use \q to exit psqlps
https://wiki.postgresql.org/wiki/First_steps 
https://chartio.com/resources/tutorials/how-to-set-the-default-user-password-in-postgresql/ 

I found these next two links were useful in resolving an error as they offered the steps and commands to use to fix the error:
https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge# 

https://www.godaddy.com/garage/how-to-install-postgresql-on-ubuntu-14-04/ 

### Build JSON File with Rake
The bar chart race needs the data in a JSON file (public/barchartcities.json). As this data only needs some of the values for each city (name, year and population), and we don't want to generate the JSON each time the page runs, it makes sense to create it via Rake so that it can be called as needed. This was done by testing queries in Postgresql's PgAdmin tool to confirm the query works correctly, and then translating this to a Rails query for use in the rake file (lib/task/cities.rake). In addition, it was a matter of manipulating other queries, and looping through the results to print out the required values for the JSON file.

The cities appeared first, but only one at a time. After creating a JSON file with only years that have 5 or more cities, then it works as a race. After adjusting some of the constants in the JS file it now looks better. There are still labelling and size issues, but this is minor.

**This is what was done to make it work:**
1. Query the database to generate list of each city
2. Query cities by range of dates
Use [Bar chart race](https://github.com/vicrazumov/bar-chart-race) as first attempt as it looks like can use by formatting query to JSON to feed to the visualisation.
3. Adding in the javascript meant learning more about Webpack and where files need to be located. Plenty to learn:
    * JSON should go under 'public' folder to be available to the app
    * [Adding custon JS details](https://dev.to/morinoko/adding-custom-javascript-in-rails-6-1ke6) clarifies where and how you load JS under Webpack, and how to import and reference your JS objects too.
    * Use Chrome to debug your JS errors - remember to clear your cache as you go along so that you see the effect of changes. 
    * Follow these instructions to [activate apache2 server on your Mac](https://websitebeaver.com/set-up-localhost-on-macos-high-sierra-apache-mysql-and-php-7-with-sslhttps) so that you can run a server to test the pages without Rails to see that everything works as it should. It did, with minor change to remove '/' from fetch command for JSON then worked in both Safari and Chrome after caches were cleared.
    * Knowing it works, means we can now work on details of doing this with Rails and Ruby.

## Version 1 - The One Table Version - No Styling - Branch Basic
Everything goes into one table, which we can manipulate to show us interesting visualisations and details about each city. Bootstrap is put in place, but not used. This is the basic branch with no styling added.

## Version 2 - One Table with Styling
We start to use Bootstrap to clean up the look and feel of the application. These are the basic links to explore for doing this:
https://getbootstrap.com/docs/4.3/getting-started/introduction/ which is the bootstrap documentation to explain its logic and inner workings.
https://www.tutorialrepublic.com/twitter-bootstrap-tutorial/ looks like it will help cover the different issues.
https://www.w3schools.com/bootstrap4/default.asp looks to be similar to the one above, but provides an alterative.

The goal is to have a responsive application, which removes tables where possible, and maintains a high contrast layout, which will be adaptable as we move forward with this project. This will not dive into editing the bootstrap files themselves. This will focus on using available css classes within bootstrap.

1. Fix banner and navigation with edits to app/view/layouts/_menu.html.erb to use bootstrap. 
2. Makes changes to table layouts with edits to the files under app/view/cities. Using 'cycle' tag in Rails enables alternate colours on rows, and tables are swapped for grid components of rows and colums.



