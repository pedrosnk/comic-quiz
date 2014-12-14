
path = require 'path'
request = require 'supertest'
app = require path.join(__dirname, '../../config/application')

describe 'Question Routes', ->

  describe 'Fetchs Questions via http', ->

    it 'Returns 200 with content-type json', (done) ->
      request app
        .get '/questions'
        .set 'Accept', 'application/json'
        .expect 'Content-Type', /json/
        .expect 200, done


