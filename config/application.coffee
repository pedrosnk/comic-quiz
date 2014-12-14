
express = require 'express'
app = express()

app.get '/questions', (req, res) ->
  res.status(200).send([])

module.exports = app
