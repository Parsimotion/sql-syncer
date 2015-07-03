config = require("../../config/environment")
User = require("../user/user.model")

exports.test = (req, res) ->
  { engine, connectionString, query } = res.body
