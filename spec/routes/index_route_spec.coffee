
path = require 'path'
request = require 'supertest'
app = require path.join(__dirname, '../../config/application')

describe 'Index Route', ->

  it 'Returns a welcome message', (done) ->
    request(app)
      .get '/'
      .expect /Welcome to Comic Quiz/, done


