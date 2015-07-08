"use strict"

mongoose = require("mongoose")
Promise = require("bluebird")
Promise.promisifyAll mongoose

Schema = mongoose.Schema

authTypes = ["producteca"]

UserSchema = new Schema
  name: String

  email:
    type: String
    lowercase: true
    required: true
    unique: true

  provider: String
  providerId: Number

  tokens:
    producteca: String

  settings:
    saved: Boolean
    engine: String
    connection:
      host: String
      database: String
      username: String
      password: String
    query: String
    priceList: String
    warehouse: String
    hours: [
      i: Number
      date: Date
      checked: Boolean
    ]

module.exports = mongoose.model("User", UserSchema)
