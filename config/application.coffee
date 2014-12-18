
path = require 'path'
express = require 'express'
app = express()

app.use express.static path.join(__dirname, '../public')
require(path.join(__dirname, 'routes'))(app)

module.exports = app
