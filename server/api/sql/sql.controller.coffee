config = include("config/environment")
User = include("api/user/user.model")
SqlSyncer = include("domain/sqlSyncer")

exports.sync = (req, res) ->
  user = req.user

  new SqlSyncer(user)
    .sync()
    .then (result) =>
      res.send 200, result

exports.batchSync = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  res.status(200).end()

  currentHour = new Date().getUTCHours()
  User
    .findAsync({ "settings.hours": { $elemMatch: { i: currentHour, checked: true } } })
    .map (user) =>
      console.log "#{currentHour}hs: It's time to sync the user #{user.name}..."
      new SqlSyncer(user).sync()

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

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
