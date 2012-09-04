_ = require("underscore")

_users = [
  {id: 1, username: "demo", password: "password"}
  {id: 2, username: "john", password: "password"}
  {id: 3, username: "linus", password: "password"}
]

module.exports = (app) ->
  findUser: (criteria, callback) ->
    conditions = for prop, val of criteria
      (user) -> user[prop] is val

    callback null, findObject(_users, criteria)

# Generic function for finding the first object in a list
# that matches each condition in a list of simple property/value criteria
findObject = (list, criteria) ->
  conditions = for prop, val of criteria
    (obj) -> obj[prop] is val

  _.find list, (obj) ->
      for cond in conditions
        # As soon as a condition returns false we know this 
        # object isn't a match
        if not cond(obj)
          false
      true
  
