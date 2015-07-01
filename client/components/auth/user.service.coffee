'use strict'

angular.module 'sql-syncer-app'
.factory 'User', ($resource) ->
  $resource '/api/users/:id/:controller',
    id: '@_id'
  ,
    changePassword:
      method: 'PUT'
      params:
        controller: 'password'

    get:
      method: 'GET'
      params:
        id: 'me'

