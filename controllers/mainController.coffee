_ = require('underscore')
util = require('util')

#
# * GET home page.
# 
module.exports = (app, repository) ->

  index : (req, res) ->
    res.render "index", 
      title: "Node Kickstarter"

  login : (req, res) ->
    # req.body.email
    # req.body.password
    #TODO: Invoke the passport.login

    res.redirect "/"