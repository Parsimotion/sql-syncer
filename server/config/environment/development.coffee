"use strict"

# Development specific configuration
# ==================================
module.exports =

  # MongoDB connection options
  mongo:
    uri: process.env.MONGO_URI or "mongodb://localhost/sql-syncer-dev"
