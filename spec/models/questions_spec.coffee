
path = require 'path'
Answer = require path.join(__dirname, "../../app/models/answer")
Question = require path.join(__dirname, "../../app/models/question")

describe 'Question', ->

  beforeEach (done) ->
    Question.remove().exec ->
      done()

  it 'creates a Question properly', (done) ->
    answer1 = new Answer text: 'Cyclo', correct: false
    answer2 = new Answer text: 'Wolvie', correct: true
    answer3 = new Answer text: 'Star', correct: false

    question = new Question
      text: 'Whos the best there is', universe: 'MARVEL', type: 'correctOne',
      answers: [answer1, answer2, answer3]

    question.save (err) ->
      (err == null).should.be.ok
      done()

  it 'recovers the created answer', (done) ->
    question = new Question
      text: 'Generic question', universe: 'MARVEL', type: 'correctOne',
    question.save (err) ->
      (err == null).should.be.ok
      Question.findOne text: question.text, (err, questionRecovered) ->
        questionRecovered.id.should.be.equal question.id
        done()


