
fs = require 'fs'
require('chai').should()

fs.readdirSync("#{__dirname}/models").forEach (file) ->
  if (file.match(/.+\.coffee$/g) != null)
    console.log file
    name = file.replace '.coffee', ''
    require "#{__dirname}/models/#{name}"

