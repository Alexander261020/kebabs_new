const { environment } = require('@rails/webpacker')
var webpack = require('webpack');
environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery/src/jquery',
  jQuery: 'jquery/src/jquery',
  jquery: 'jquery',
  'window.jQuery': 'jquery',
}))
module.exports = environment
