
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
      throw err if err
      res.status(201).send { "result": "ok" }

questions_router.route('/:id')
  .get (req, res) ->
    Question.findOne _id: req.params.id, (err, question) ->
      throw err if err
      res.status(200).send question
  .delete (req, res) ->
    Question.remove _id: req.params.id, (err) ->
      throw err if err
      res.status(200).send {"result": "ok"}
  .patch (req, res) ->
    res.sendStatus(200)

module.exports = questions_router
