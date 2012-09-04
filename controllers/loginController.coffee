
module.exports = (app, dependencies) ->

  # Post the login credentials
  app.post "/login", dependencies.passport.authenticate 'local',
    successRedirect: '/'
    failureRedirect: '/loginfail'

  app.get "/logout", (req, res) ->
    req.logOut()
    res.redirect('/')

  app.get "/loginfail", (req, res) ->
    res.render 'loginfail'