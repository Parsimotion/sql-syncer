'use strict'

app.factory "Sql", ($http) ->
  test: (params) ->
    $http.post "/api/sql/connection/test", params
