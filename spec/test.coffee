
fs = require 'fs'
require('chai').should()

loadFilesAtFolter = (folder) ->
  fs.readdirSync("#{__dirname}/#{folder}").forEach (file) ->
    if (file.match(/.+\.coffee$/g) != null)
      name = file.replace '.coffee', ''
      require "#{__dirname}/#{folder}/#{name}"

loadFilesAtFolter 'models'
loadFilesAtFolter 'routes'
