
# Module Dependencies
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose
Languages = require(path.join(__dirname, '../../config/languages'))

# Nested object for Answer model
answerSchema = mongoose.Schema
  text: Languages,
  correct: Boolean,
  { id: false, _id: false }


# Method That receives a String of the language id and returns
# the actual text for that answer
# @param [String] lang key for the language
# @return [String] The actual String to be returned
answerSchema.methods.iText = (lang) ->
  @text[lang]

Answer = mongoose.model 'Answer', answerSchema

module.exports = Answer
