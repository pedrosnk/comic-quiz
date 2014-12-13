path = require 'path'
Answer = require path.join(__dirname, "../../app/models/answer")
Question = require path.join(__dirname, "../../app/models/question")

describe 'Question', ->

  before (done) ->
    Question.remove().exec ->
      done()

  it 'Creates a Question properly', (done) ->
    answer1 = new Answer text: 'Cyclo', correct: false
    answer2 = new Answer text: 'Wolvie', correct: true
    answer3 = new Answer text: 'Star', correct: false

    question = new Question
      text: 'Whos the best there is', universe: 'MARVEL', type: 'correctOne',
      answers: [answer1, answer2, answer3]

    question.save (err) ->
      (err == null).should.be.ok
      done()

  it 'Recovers the created answer', (done) ->
    question = new Question
      text: 'Generic question', universe: 'MARVEL', type: 'correctOne',
    question.save (err) ->
      (err == null).should.be.ok
      Question.findOne _id: question.id, (err, questionRecovered) ->
        questionRecovered.text.should.be.equal question.text
        done()

  it 'Fetchs a question by it meta datas properly', (done) ->
    question = new Question
      text: 'Your neighborhood friend', type: 'correctOne',
      meta:
        publisher: 'MARVEL', character: 'spider-man'
    question.save (err) ->
      Question.findOne 'meta.publisher': 'MARVEL', 'meta.character': 'spider-man', (err, questionRecovered) ->
        question.id.should.be.equal questionRecovered.id
        done()


