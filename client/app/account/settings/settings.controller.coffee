'use strict'

app.controller 'SettingsCtrl', ($scope, $state, Settings, User, Producteca, Sql) ->
  $scope.settings = Settings.query()
  $scope.user = User.get()

  $scope.user.$promise.then (me) =>
    Producteca.then (Producteca) =>
      producteca = new Producteca me.tokens.producteca
      $scope.priceLists = producteca.priceLists()
      $scope.warehouses = producteca.warehouses()

  $state.go "settings.sqlconnection"
  $scope.settings.$promise.then (settings) =>
    makeDate = (hour) =>
      date = new Date() ; date.setUTCHours hour
      date.setUTCMinutes 0 ; date.setUTCSeconds 0 ; date.setUTCMilliseconds 0
      date

    hours = [10..23].concat(0).map (it) =>
      i: it, date: makeDate(it), checked: false

    settings.hours =
      if settings.hours?
        merge = settings.hours
          .map (hour) => _.assign hour, date: new Date(hour.date)
          .concat(hours)
        _.uniq merge, "i"
      else hours

  goToTestResults = (success, result) =>
    $scope.isTestingDb = false
    $scope.result = result
    example = $scope.example = _.first result

    validators = [
      check: -> not success
      status: "error"
    ,
      check: -> _.isEmpty result
      status: "empty"
    ,
      check: -> not example.barcode? and not example.sku?
      status: "unknown_identifier"
    ,
      check: -> example.barcode? and example.sku?
      status: "two_identifiers"
    ,
      check: -> not example.price? and not example.stock?
      status: "columns_not_found"
    ,
      { check: (-> true), status: "success" }
    ]

    $scope.testMessage = (_.find validators, (it) -> it.check()).status
    $state.go "settings.test"

  $scope.test = =>
    $scope.isTestingDb = true

    Sql.test($scope.settings).success (response) =>
      result = _(response)
        .map (item) =>
          item.identifier = item.barcode || item.sku
          item
        .take 5
        .value()

      goToTestResults true, result
    .error (error) =>
      goToTestResults false, error

  $scope.save = (form) =>
    $scope.submitted = true

    if form.$valid
      $scope.settings.saved = true
      Settings.update($scope.settings).$promise
      .then ->
        $scope.message = 'Configuración actualizada!'
      .catch ->
        $scope.message = 'Hubo un error :('
