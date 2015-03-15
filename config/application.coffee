
path = require 'path'
express = require 'express'
app = express()

app.use express.static path.join(__dirname, '../public')
app.engine 'html', require('ejs').renderFile
app.set 'view engine', 'html'
app.set 'views', path.join(__dirname, '../app/views')

require(path.join(__dirname, 'routes'))(app)

module.exports = app
