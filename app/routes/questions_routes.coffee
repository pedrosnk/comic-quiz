
express = require 'express'

questions_router = express.Router();

questions_router.route('/')
  .get (req, res) ->
    res.status(200).send([])

module.exports = questions_router
