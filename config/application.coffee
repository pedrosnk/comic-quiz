
path = require 'path'
express = require 'express'
app = express()

require(path.join(__dirname, 'routes'))(app)

module.exports = app
