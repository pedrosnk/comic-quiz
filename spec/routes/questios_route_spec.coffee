
path = require 'path'
request = require 'supertest'
app = require path.join(__dirname, '../../config/application')
Question = require path.join(__dirname, "../../app/models/question")

describe 'Question Routes', ->

  describe 'Fetchs Questions via http', ->
    before (done) ->
      Question.create [
        { text: { en: 'question1' }, type: 'correctOne' },
        { text: { en: 'question2' }, type: 'correctOne' },
        { text: { en: 'question3' }, type: 'correctOne' },
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

    it 'Creates a Question by sending a encoded url form', (done) ->
      urlEncoded = "[text][en]=#{questionBody.text.en}&"
      urlEncoded += "type=#{questionBody.type}&[meta][universe]=#{questionBody.meta.universe}"
      request(app)
        .post '/questions'
        .send urlEncoded
        .end (err) ->
          throw err if err
          Question.findOne text: { en: questionBody.text.en }, (err, question) ->
            (question == null).should.not.be.ok
            done()


  describe 'Deletes a Question', () ->
    questionToBeDeleted = null
    beforeEach (done) ->
      Question.create
        text: { en: 'This is a question' }
        type: 'correctOne'
        (err, question) ->
          throw err if err
          questionToBeDeleted = question
          done()

    after (done) ->
      Question.remove().exec -> done()

    it 'Send a delete method and returns a 200', (done) ->
      request(app)
        .delete "/questions/#{questionToBeDeleted.id}"
        .expect 200, done

    it 'Removes the question properly', (done) ->
      request(app)
        .delete "/questions/#{questionToBeDeleted.id}"
        .expect (res) ->
          res.body.result.should.be.ok
          false
        .end (err) ->
          throw err if err
          done()

  describe 'GET a Question', ->
    questionToBeShow = null

    before (done) ->
      Question.create
        text: { en: 'This is a question' }
        type: 'correctOne'
        (err, question) ->
          throw err if err
          questionToBeShow = question
          done()

    after (done) ->
      Question.remove().exec -> done()


    it 'Returns a 200 and Content json', (done) ->
      request(app)
        .get "/questions/#{questionToBeShow.id}"
        .set 'Accepts', 'application/json'
        .expect 'Content-Type', /json/
        .expect 200, done

    it 'Retreives the json from the Question properly', (done) ->
      request(app)
        .get "/questions/#{questionToBeShow.id}"
        .set 'Accepts', 'application/json'
        .expect (res) ->
          res.body.text.en.should.be.equal questionToBeShow.text.en
          false
        .end (err) ->
          throw err if err
          done()

  describe 'Update a Question', ->
    questionToBeUpdated = null
    beforeEach (done) ->
      Question.create
        text: { en: 'This is a question' }
        type: 'correctOne'
        (err, question) ->
          throw err if err
          questionToBeUpdated = question
          done()

    after (done) ->
      Question.remove().exec -> done()

    it 'Returns an 200 status code for update via patch', (done) ->
      request(app)
        .patch "/questions/#{questionToBeUpdated.id}"
        .expect 200, done

    it 'Updates a question via API', (done) ->
      updateText = { text: en: 'This is an updated question' }
      request(app)
        .patch "/questions/#{questionToBeUpdated.id}"
        .set 'Content-Type', 'application/json'
        .send updateText
        .end (err) ->
          throw err if err
          Question.findOne _id: questionToBeUpdated.id, (err, question) ->
            throw err if err
            question.text.en.should.be.equal updateText.text.en
            done()



