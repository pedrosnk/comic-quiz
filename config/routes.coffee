
path = require 'path'
questions_routes = require path.join(__dirname, '../app/routes/questions_routes')

module.exports = (app) ->

  app.use '/questions', questions_routes


