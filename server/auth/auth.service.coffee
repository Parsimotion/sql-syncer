"use strict"
passport = require("passport")
config = require("../config/environment")
User = require("../api/user/user.model")

exports.authenticated = (req, res, next) ->
  reject = -> res.send 401

  if req.isAuthenticated()
    User.findOneAsync(req.user._id)
      .then (user) -> req.user = user ; next()
      .catch reject
  else reject()

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"
