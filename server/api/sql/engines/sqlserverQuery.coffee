mssql = require("mssql")
Promise = require("bluebird")
module.exports =

# A SqlServer query.
# connection = { host, username, password, database }
class SqlServerQuery
  constructor: (@connection) ->

  # Executes the query and returns a promise with the results.
  get: (query) =>
    new Promise (resolve, reject) =>
      config =
        server: @connection.host
        database: @connection.database
        user: @connection.username
        password: @connection.password
        options: encrypt: true

      connection = new mssql.Connection config, (err) =>
        if err then return reject err

        connection
          .request()
          .query query, (err, recordSet) =>
            if err then return reject err
            resolve recordSet
