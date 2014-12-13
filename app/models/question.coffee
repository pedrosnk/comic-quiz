
# Module Dependencies
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose
timestamps = require 'mongoose-timestamp'
Answer = require( path.join(__dirname, 'answer') )
Languages = require(path.join(__dirname, '../../config/languages'))

# Definition for the Schema of the Question Documents
questionSchema = mongoose.Schema
  text: Languages,
  type: { type: String },
  answers: [Answer.schema],
  meta: mongoose.Schema.Types.Mixed

# Returns The text translated properlly
# @param [String] lang key for the language
# @return [String] The actual String to be returned
questionSchema.methods.iText = (lang) ->
  @text[lang]

# add a plugin to integrate with the timestaps models
questionSchema.plugin timestamps, { 'createdAt': 'cAt', 'updatedAt': 'uAt' }

Question = mongoose.model 'Question', questionSchema
module.exports = Question

