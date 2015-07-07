"use strict"
express = require("express")
controller = require("./sql.controller.coffee")
auth = include("auth/auth.service")

router = express.Router()

router.post "/sync", auth.authenticated, controller.sync
router.post "/connection/test", auth.authenticated, controller.test

module.exports = router
