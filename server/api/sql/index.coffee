"use strict"
express = require("express")
controller = require("./sql.controller.coffee")
auth = require("../../auth/auth.service")

router = express.Router()

router.post "/connection/test", auth.authenticated, controller.test

module.exports = router
