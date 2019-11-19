# Historical Cities 

This is a Rails app based on the Urban Spatial Data from 3700BC to 2000AD found at https://sedac.ciesin.columbia.edu/data/set/urbanspatial-hist-urban-pop-3700bc-ad2000 The spreadsheet needed to be imported into the app, and https://spin.atomicobject.com/2017/03/22/parsing-excel-files-ruby/ provides a comparative guide to parsing Excel files with different gems. This uses the Creek gem to import the spreadsheet using rake. https://github.com/pythonicrubyist/creek as it provides fast importing of large datasets.

You'll find the current version of the app running on Heroku at http://fathomless-scrubland-43773.herokuapp.com Given the restrictions there this will be a reduced dataset to stay under 10k records in the database. One noticable difference in working so closely with Postgresql on this app, is that PG is much fussier about queries than sqlite3, which is being run locally. In particular, the table column names needed to be changed as they all start with capitals, which is not allowed in PG. This rendered some queries impossible.

We'll use Webpack with Bootstrap following this guide on Medium https://medium.com/@guilhermepejon/how-to-install-bootstrap-4-3-in-a-rails-6-app-using-webpack-9eae7a6e2832 so that the pages look better and we have a working example to style things a little bit by working through bootstrap basics at https://getbootstrap.com/docs/4.3/getting-started/introduction/ to remove tables and add other suitable styling.rail

The goal is to explore how we might use this dataset to develop increasingly better versions of a web application. There are 10300+ records in the dataset.
For all of these we use the 'will_paginate' gem at https://github.com/mislav/will_paginate for pagination.

#Version 1
Everything goes into one table, which we can manipulate accordinly to show us interesting visualisations.



