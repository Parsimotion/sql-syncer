_ = require("lodash")
_.mixin require("lodash-deep")

###
This is a transformer between the model and the DTO that the settings will use
###
class Transformer
  constructor: (@mappings) ->

  toDto: (model) ->
    dto = {}

    setValue = _.partial @_updateProperty, dto, model
    @mappings.forEach ({from, to}) -> setValue to, from

    dto

  updateModel: (model, dto) ->
    setValue = _.partial @_updateProperty, model, dto
    @mappings.forEach ({from, to}) -> setValue from, to, true

  _updateProperty: (destination, source, destinationPropertyPath, sourcePropertyPath, ignoreNullAndUndefined = false) ->
    newValue = _.deepGet source, sourcePropertyPath

    if ignoreNullAndUndefined && !newValue?
      return

    if _.isFunction destination.set
      destination.set destinationPropertyPath, newValue
    else
      _.deepSet destination, destinationPropertyPath, newValue

module.exports = new Transformer [
  from: "settings.saved", to: "saved"
,
  from: "settings.engine", to: "engine"
,
  from: "settings.connection", to: "connection"
,
  from: "settings.query", to: "query"
,
  from: "settings.priceList", to: "priceList"
,
  from: "settings.warehouse", to: "warehouse"
]
