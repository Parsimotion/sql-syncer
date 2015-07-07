config = include("config/environment")
User = include("api/user/user.model")
SqlSyncer = include("domain/sqlSyncer")

exports.sync = (req, res) ->
  user = req.user

  new SqlSyncer(user)
    .sync()
    .then (result) =>
      res.send 200, result

exports.test = (req, res) ->
  testData = req.body || {}
  { engine, query, connection } = testData

  connection = connection || {}
  engine = testData.engine || "mysql"

  SqlQuery = include("domain/engines/#{engine}Query")
  new SqlQuery(connection)
    .get query
    .then (data) -> res.send 200, data
    .catch (e) -> res.send 400, e
