
# Module Dependencies
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose

# Nested object for Answer model
answerSchema = mongoose.Schema text: String, correct: Boolean,
  { id: false, _id: false }

Answer = mongoose.model 'Answer', answerSchema

module.exports = Answer
