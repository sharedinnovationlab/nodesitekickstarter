
express = require("express")
http = require("http")
path = require("path")
util = require("util")
app = express()
passport = require('passport')
requireDir = require('require-dir');
localStrategy = require('passport-local').Strategy

# Create a dependency object to pass into various modules
dependencies = 
  repository : require('./repository')(app)

security = require("./security")(app, dependencies)

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set 'view engine', 'jade'

  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")

  app.use express.session(secret: 'keyboard cat')
  
  # Register all our security related middleware at once
  security.registerMiddleware app

  # Ensure the following 3 lines are in order
  app.use express.static(path.join(__dirname, "public"))
  app.use require('connect-assets')()
  app.use app.router

app.configure "development", ->
  app.use express.errorHandler()
  app.locals.pretty = true

# Register a global viewHelper module that is accessible in 
# view files via viewHelper.functionName()
app.locals.viewHelper = require("./viewHelper")(app)

# Require each of the controller modules
for module, controller of requireDir('./controllers')
  controller app, dependencies

# Any request that falls all the way through is considered a 404
# Make sure this comes after all the controllers register 
# their routes.
app.use (req, res) ->
  res.render "404", status: 404, title: "Page not found"

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
