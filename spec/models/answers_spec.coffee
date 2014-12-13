
path = require 'path'
Answer = require path.join(__dirname, "../../app/models/answer")

describe 'I18n Operation for Answer', ->

  it 'Add i18n operation for Answer', ->
    answer = new Answer
      text: { en: 'Storm', pt_BR: 'Tempestade' }
    answer.iText('en').should.be.equal 'Storm'
    answer.iText('pt_BR').should.be.equal 'Tempestade'

