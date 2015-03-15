
path = require 'path'
questions_routes = require path.join(__dirname, '../app/routes/questions_routes')
bodyParser = require 'body-parser'
module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render('index')
  app.use bodyParser.json()
  app.use bodyParser.urlencoded extended: true
  app.use '/questions', questions_routes

