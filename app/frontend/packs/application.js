import Rails from "@rails/ujs"
// import "channels"
Rails.start()
import "../styles/application.scss"
const images = require.context('../images', true)
import "bootstrap/dist/js/bootstrap.js"

import "../sctipts/maps.js"
import "../sctipts/hide_window.js"

// import "../sctipts/jquery-1.10.2.min.js"
import "../sctipts/lightbox.js"
