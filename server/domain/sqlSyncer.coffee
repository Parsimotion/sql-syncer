config = include("config/environment")

SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Adjustment = SDK.Sync.Adjustment
Syncer = SDK.Sync.Syncer

_ = require("lodash")

module.exports =

class SqlSyncer
  constructor: (user) ->
    @settings = user.settings
    @defaultSyncOptions =
      priceList: @settings.priceList
      warehouse: @settings.warehouse,
      synchro: prices: false, stocks: false
      identifier: "barcode"

    @productecaApi = new ProductecaApi
      accessToken: user.tokens.producteca
      url: config.producteca.uri

  getAdjustmentsAndOptions: =>
    SqlQuery = require("./engines/#{@settings.engine}Query")
    new SqlQuery(@settings.connection)
      .get @settings.query
      .then (data) =>
        options = _.clone @defaultSyncOptions

        example = _.first data
        if example?
          options.synchro.prices = example.price?
          options.synchro.stocks = example.stock?
          options.identifier =
            if example.sku? then "sku" else "barcode"

        adjustments:
          data.map (it) =>
            new Adjustment
              identifier: it.barcode || it.sku
              price: "#{it.price}"
              stock: "#{it.stock}"
        options: options

  sync: =>
    @getAdjustmentsAndOptions().then ({ adjustments, options }) =>
      @productecaApi.getProducts().then (products) =>
        new Syncer(@productecaApi, options, products)
          .execute adjustments
