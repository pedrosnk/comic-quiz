
path = require 'path'
request = require 'supertest'
app = require path.join(__dirname, '../../config/application')
Question = require path.join(__dirname, "../../app/models/question")

describe 'Question Routes', ->

  describe 'Fetchs Questions via http', ->
    before (done) ->
      Question.create [
        { text: { en: 'question1' } },
        { text: { en: 'question2' } },
        { text: { en: 'question3' } },
      ], (err) ->
        throw err if err
        done()

    after (done) ->
      Question.remove().exec -> done()

    it 'Returns 200 with content-type json', (done) ->
      request app
        .get '/questions'
        .set 'Accept', 'application/json'
        .expect 'Content-Type', /json/
        .expect 200, done

    it 'Returns Questions Object Properly', (done) ->
      request app
        .get '/questions'
        .set 'Accept', 'application/json'
        .expect (res) ->
          questionTexts = res.body.map (question) ->
            question.text.en
          questionTexts.should.contain 'question1'
          questionTexts.should.contain 'question2'
          questionTexts.should.contain 'question3'
          false
        .end (err) ->
          throw err if (err)
          done()

  describe 'Creates the Question', ->

    questionBody =
      text: { en: 'This is a question' }
      type: 'correctOne'
      meta: { universe: 'MARVEL' }

    after (done) ->
      Question.remove().exec -> done()

    it 'Returns a 201 status code for created question', (done) ->
      request(app)
        .post '/questions'
        .set 'Content-Type', 'application/json'
        .send questionBody
        .expect 'Content-Type', /json/
        .expect 201, done

    it 'Creates a Question by sending a json object', (done) ->
      request(app)
        .post '/questions'
        .send questionBody
        .end (err) ->
          throw err if err
          Question.findOne text: { en: questionBody.text.en }, (err, question) ->
            (question == null).should.not.be.ok
            done()


