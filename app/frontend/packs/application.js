import Rails from "@rails/ujs"
// import "channels"
Rails.start()

import "../styles/application.scss"
import "../sctipts/hide_window.js"
import "../sctipts/maps.js"
const images = require.context('../images', true)
import "bootstrap/dist/js/bootstrap.js"
