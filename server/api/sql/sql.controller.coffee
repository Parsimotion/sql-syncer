config = require("../../config/environment")
User = require("../user/user.model")

exports.test = (req, res) ->
  testData = req.body || {}
  { engine, query, connection } = testData

  connection = connection || {}
  engine = testData.engine || "mysql"

  SqlQuery = require("./engines/#{engine}Query")
  new SqlQuery(connection)
    .get query
    .then (data) -> res.send 200, data
    .catch (e) -> res.send 400, e
