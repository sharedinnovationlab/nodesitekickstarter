# Use this module to define helper functions that can be called from views.

_ = require("underscore")

_months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

module.exports = (app) ->
  displayDate: () ->
    dt = new Date()
    "Today, " + _months[dt.getMonth()] + " " + dt.getDay()
