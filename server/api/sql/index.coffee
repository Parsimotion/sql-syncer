"use strict"
express = require("express")
controller = require("./sql.controller.coffee")
auth = require("../../auth/auth.service")

router = express.Router()

router.get "/test", controller.test #auth.authenticated

module.exports = router
