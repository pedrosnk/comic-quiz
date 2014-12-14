
path = require 'path'
express = require 'express'
Question = require path.join(__dirname, '../models/question')
questions_router = express.Router();

questions_router.route('/')
  .get (req, res) ->
    Question.find (err, questions) ->
      res.status(200).send(questions)

module.exports = questions_router
