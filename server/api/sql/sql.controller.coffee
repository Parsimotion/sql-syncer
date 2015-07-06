config = require("../../config/environment")
User = require("../user/user.model")
MySqlQuery = require("./engines/mySqlQuery")

exports.test = (req, res) ->
  testData = req.body || {}
  connection = testData.connection || {}

  new MySqlQuery(connection)
    .get testData.query
    .then (data) -> res.send 200, data
    .catch (e) -> res.send 400, e
