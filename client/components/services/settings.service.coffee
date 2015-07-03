app.factory "Settings", ($resource) ->
  $resource "/api/settings", {},
    query:
      isArray: false
      transformResponse: (data) ->
        settings = JSON.parse data
        settings

    update:
      method: "PUT"
      transformRequest: (settings) ->
        JSON.stringify settings

app.factory "User", ($resource) ->
  $resource "/api/users/me", {},
    me:
      isArray: false
      transformResponse: (data) ->
        settings = JSON.parse data
        settings
