
path = require 'path'
express = require 'express'
Question = require path.join(__dirname, '../models/question')
questions_router = express.Router();

questions_router.route('/')
  .get (req, res) ->
    Question.find (err, questions) ->
      res.status(200).send(questions)

  .post (req, res) ->
    question = new Question req.body
    question.save (err) ->
      unless err
        res.status(201).send { "result": "ok" }
      else
        res.status(201).send { "result": "fail" }

module.exports = questions_router
