'use strict'

app.controller 'SettingsCtrl', ($scope, $state, Settings, User, Producteca) ->
  $scope.settings = Settings.query()
  $scope.user = User.get()

  $scope.user.$promise.then (me) =>
    Producteca.then (Producteca) =>
      producteca = new Producteca me.tokens.producteca
      $scope.priceLists = producteca.priceLists()
      $scope.warehouses = producteca.warehouses()

  $state.go "settings.sqlconnection"
  $scope.settings.$promise.then (settings) =>
    if not settings.saved
      ; # set to settings some default values

  $scope.save = (form) ->
    $scope.submitted = true

    if form.$valid
      $scope.settings.saved = true
      Settings.update($scope.settings).$promise
      .then ->
        $scope.message = 'Configuración actualizada!'
      .catch ->
        $scope.message = 'Hubo un error :('
