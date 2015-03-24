
path = require 'path'
morgan = require 'morgan'
express = require 'express'
app = express()

app.use express.static path.join(__dirname, '../public')
app.use morgan('dev')
app.engine 'html', require('ejs').renderFile
app.set 'view engine', 'html'
app.set 'views', path.join(__dirname, '../views')

require(path.join(__dirname, 'routes'))(app)

module.exports = app
