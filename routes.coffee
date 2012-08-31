util = require('util')
_ = require('underscore')

# Module which encapsulates all the application routes
module.exports = (app, controllers, repository) ->
  # app.get "/", (req, res) ->
  #   action = req.params['action'] || 'index'
  #   controllers.main[action](req, res)

  app.get "/:action?", [authorize], (req, res) ->
    action = req.params['action'] || 'index'
    controllers.main[action](req, res)

  app.get "/:controller/:action?", [authorize], (req, res) ->
    controllers[req.params['controller']][req.params['action']](req, res)

  app.get "/:controller/:action/:id", [authorize], (req, res) ->
    req.id = req.params['id']
    controllers[req.params['controller']][req.params['action']](req, res)

  app.post "/login", controllers.main.login

  # Any request that falls all the way through is considered a 404
  app.use (req, res) ->
    res.render "404", status: 404, title: "Page not found"
    
# Authorization middleware function
authorize = (req, res, next) ->
  #TODO: Perform any custom authorization logic
  authorized = true
  if authorized is false
    res.render "403", status: 403, title: "Unauthorized access"
  else
    next()