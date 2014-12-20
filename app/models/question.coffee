
# Module Dependencies
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose
timestamps = require 'mongoose-timestamp'
Answer = require( path.join(__dirname, 'answer') )
Languages = require(path.join(__dirname, '../../config/languages'))

validationAtLeastOneText =
  [ (text) -> Object.keys(text).length > 0
  ,
  '{PATH} must have at least one text'
  ]

# Definition for the Schema of the Question Documents
questionSchema = mongoose.Schema
  text: { type: Languages,  required: true, validate: validationAtLeastOneText }
  type: { type: String, required: true },
  answers: [Answer.schema],
  meta: mongoose.Schema.Types.Mixed

# Returns The text translated properlly
# @param [String] lang key for the language
# @return [String] The actual String to be returned
questionSchema.methods.iText = (lang) ->
  @text[lang]

questionSchema.on

# add a plugin to integrate with the timestaps models
questionSchema.plugin timestamps, { 'createdAt': 'cAt', 'updatedAt': 'uAt' }

Question = mongoose.model 'Question', questionSchema
module.exports = Question

