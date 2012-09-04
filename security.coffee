# Module which encapsulates security related aspects for the app.

module.exports = (app, dependencies) ->
  passport = dependencies.passport

  # Configure Passport to use a local username/password strategy
  localStrategy = require('passport-local')
  passport.use 'local', new localStrategy.Strategy (username, password, done) ->
    dependencies.repository.findUser {username}, (err, user) ->
      return done(err) if err
      return done(null, false, message: 'Unkown user') unless user?

      if user.password isnt password
        return done(null, false, message: "Invalid password")

      done(null, user)

  passport.serializeUser (user, done) ->
    # Serialize the user by simply emitting their id
    # Could also do a custom serialization of the entire user object
    console.log "Serializing user #{user.id}"
    done null, user.id

  passport.deserializeUser (id, done) ->
    console.log "Deserializing user #{id}"
    # Deserialize the user by looking them up
    dependencies.repository.findUser {id}, (err, user) ->
      done err, user

  registerMiddleware : (app) ->
   app.use passport.initialize()
   app.use passport.session()
   
   app.use (req, res, next) ->
    res.locals.user = req.user
    next()