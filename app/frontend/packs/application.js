import Rails from "@rails/ujs"
// import "channels"
Rails.start()

import "../styles/application.scss"
const images = require.context('../images', true)
import "bootstrap/dist/js/bootstrap.js"
