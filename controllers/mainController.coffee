_ = require('underscore')
util = require('util')

module.exports = (app, context) ->
  #
  # * GET home page.
  # 
  app.get "/", (req, res) ->
    res.render "index", 
      title: "Node Kickstarter"