# Historical Cities 

This is a Ruby on Rails app based on the Urban Spatial Data from 3700BC to 2000AD found at https://sedac.ciesin.columbia.edu/data/set/urbanspatial-hist-urban-pop-3700bc-ad2000 The spreadsheet needed to be imported into the app, and https://spin.atomicobject.com/2017/03/22/parsing-excel-files-ruby/ provides a comparative guide to parsing Excel files with different gems. This uses the Creek gem to import the spreadsheet using rake. https://github.com/pythonicrubyist/creek as it provides fast importing of large datasets.

## See me running
You'll find the current 'ugly duckling' version of the app running on Heroku at http://fathomless-scrubland-43773.herokuapp.com Given the restrictions there this will be a reduced dataset to stay under 10k records in the database. One noticable difference in working so closely with Postgresql on this app, is that PG is much fussier about queries than sqlite3, which is being run locally. In particular, the table column names needed to be changed as they all start with capitals, which is not allowed in PG. This rendered some queries impossible.

## Rails 6
This project is also a chance to explore Rails 6, and it's changes. There will be notes here about what's working and which guides have been useful for me and this project. 

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

#Version 1 - The One Table Version
Everything goes into one table, which we can manipulate to show us interesting visualisations and details about each city.



