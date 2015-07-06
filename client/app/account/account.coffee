'use strict'

angular.module 'sql-syncer-app'
.config ($stateProvider) ->
  $stateProvider
  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'

  .state 'settings.sqlconnection',
    url: '/sqlconnection'
    templateUrl: 'app/account/settings/settings-sqlconnection.html'

  .state 'settings.test',
    url: '/test'
    templateUrl: 'app/account/settings/settings-test.html'

  .state 'settings.syncer',
    url: '/syncer'
    templateUrl: 'app/account/settings/settings-syncer.html'
