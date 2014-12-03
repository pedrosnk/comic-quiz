
path = require 'path'
mongoose = require 'mongoose'
environmentConfigs = require path.join(__dirname, 'environment')

environment = process.env.NODE_ENV || 'development'
config = environmentConfigs[environment]

mongoose.connect config.db.path
module.exports = mongoose: mongoose

