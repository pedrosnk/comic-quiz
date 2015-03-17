
path = require 'path'
express = require 'express'
Question = require path.join(__dirname, '../models/question')
questions_router = express.Router();

questions_router.route('/')
  .get (req, res) ->
    if req.accepts('json') && !req.accepts('html')
      Question.find (err, questions) ->
        res.status(200).send(questions)
    else
      res.render 'questions/index'

  .post (req, res) ->
    question = new Question req.body
    question.save (err) ->
      throw err if err
      res.redirect 301, '/questions'

questions_router.get '/new', (req, res) ->
  res.render 'questions/new'
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
    Question.findOneAndUpdate _id: req.params.id, req.body, (err) ->
      throw err if err
      res.status(200).send { "result": "ok" }

module.exports = questions_router
