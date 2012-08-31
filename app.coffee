
express = require("express")
http = require("http")
path = require("path")
util = require("util")
app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()

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

repository = require('./repository')(app)

# Instantiate the controller modules
controllers = 
  main: require('./controllers/mainController')(app, repository)
  
require('./routes')(app, controllers, repository)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
