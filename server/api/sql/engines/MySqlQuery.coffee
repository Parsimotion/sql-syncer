promisify = require("bluebird").promisifyAll
mysql = require("mysql")
module.exports =

# A MySql query.
# connection = { host, username, password, database }
class MySqlQuery
  constructor: (@connection) ->

  # Executes the query and returns a promise with the results.
  get: (query) =>
    session = promisify mysql.createConnection
      host: @connection.host
      database: @connection.database
      user: @connection.username
      password: @connection.password

    session.connect()

    session.queryAsync(query)
      .spread (rows, fields) => rows
      .finally => session.end()
