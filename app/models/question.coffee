
# Module Dependencies
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose
timestamps = require 'mongoose-timestamp'
Answer = require( path.join(__dirname, 'answer') )

# Definition for the Schema of the Question Documents
questionSchema = mongoose.Schema
  text: { pt_BR: String, en: String },
  type: { type: String },
  answers: [Answer.schema],
  meta: mongoose.Schema.Types.Mixed

questionSchema.methods.iText = (lang) ->
  @text[lang]

# add a plugin to integrate with the timestaps models
questionSchema.plugin timestamps, { 'createdAt': 'cAt', 'updatedAt': 'uAt' }

Question = mongoose.model 'Question', questionSchema
module.exports = Question

