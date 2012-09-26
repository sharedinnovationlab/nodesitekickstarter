passport = require('passport')

module.exports = (app, dependencies) ->

  # Post the login credentials
  app.post "/login", passport.authenticate 'local',
    successRedirect: '/'
    failureRedirect: '/loginfail'

  app.get "/logout", (req, res) ->
    req.logOut()
    res.redirect('/')

  app.get "/loginfail", (req, res) ->
    res.render 'loginfail',
      title: 'Login Failed'