
path = require 'path'
mongoose = require(path.join(__dirname, '../../config/db')).mongoose
timestamps = require 'mongoose-timestamp'
Answer = require( path.join(__dirname, 'answer') )

questionSchema = mongoose.Schema
  text: String, universe: String,
  type: String, answers: [Answer.schema],

questionSchema.plugin timestamps, { 'createdAt': 'cAt', 'updatedAt': 'uAt' }

Question = mongoose.model 'Question', questionSchema
module.exports = Question

