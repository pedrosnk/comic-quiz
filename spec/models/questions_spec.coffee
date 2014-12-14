path = require 'path'
Answer = require path.join(__dirname, "../../app/models/answer")
Question = require path.join(__dirname, "../../app/models/question")

describe 'Basic CRUD for Question', ->

  before (done) ->
    Question.remove().exec -> done()

  after (done) ->
    Question.remove().exec -> done()

  it 'Creates a Question properly', (done) ->
    answer1 = new Answer text: 'Cyclo', correct: false
    answer2 = new Answer text: 'Wolvie', correct: true
    answer3 = new Answer text: 'Star', correct: false

    question = new Question
      text: { en: 'Whos the best there is' }, universe: 'MARVEL', type: 'correctOne',
      answers: [answer1, answer2, answer3]

    question.save (err) ->
      (err == null).should.be.ok
      done()

  it 'Recovers the created answer', (done) ->
    question = new Question
      text: { en: 'Generic question' }, universe: 'MARVEL', type: 'correctOne',
    question.save (err) ->
      (err == null).should.be.ok
      Question.findOne _id: question.id, (err, questionRecovered) ->
        questionRecovered.iText('en').should.be.equal question.iText('en')
        done()

  it 'Fetchs a question by it meta datas properly', (done) ->
    question = new Question
      text: { en: 'Your neighborhood friend' }, type: 'correctOne',
      meta:
        publisher: 'MARVEL', character: 'spider-man'
    question.save (err) ->
      Question.findOne 'meta.publisher': 'MARVEL', 'meta.character': 'spider-man', (err, questionRecovered) ->
        question.id.should.be.equal questionRecovered.id
        done()

describe 'I18n Operations for Questions', ->
  it 'Add i18n support to the question', ->
    question = new Question
      text: { pt_BR: 'Quem é o parceiro do Batman', en: 'Who is Batman`s sidekick' }
    question.iText('pt_BR').should.be.equal 'Quem é o parceiro do Batman'
    question.iText('en').should.be.equal 'Who is Batman`s sidekick'

