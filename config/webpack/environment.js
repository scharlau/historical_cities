const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    BarChartRace: 'barchart_race.js',
    jQuery: 'jquery',
    leaflet: 'leaflet',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
