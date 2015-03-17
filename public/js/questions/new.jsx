
var AnswerField = React.createClass({
  render: function(){
    var inputNameText = '[answers]['+this.props.answerNum+'][text][en]'
    var inputNameCorrect = '[answers]['+this.props.answerNum+'][correct]'
    var template =
      <div className='form-group'>
        <label>Answer {this.props.answerNum + 1} </label>
        <input type='text' className='form-control' name={inputNameText} />
        <div className='checkbox'>
          <label>
            <input type='checkbox' className='answer-correct-field' name={inputNameCorrect} /> Correct Answer
          </label>
        </div>
      </div>
    return template;
  }
});

var NewQuestion = React.createClass({
  submitForm : function(e) {
//    e.preventDefault();
//$.post('/questions', this..serialize())
  },
  render : function(){
    var answers = _.map([0,1,2, 3], function(n){
      return <AnswerField key={n} answerNum={n} />
    });

    var template =
      <div className='col-lg-6'>
        <h2>New Question</h2>
        <form className='form' method='POST' action='/questions' >
          <div className='form-group'>
            <label htmlFor='textField'>Text</label>
            <input id='textField' className='form-control' name='[text][en]' />
          </div>
          <div className='form-group'>
            <label htmlFor='typeField'>Type</label>
            <input id='typeField' className='form-control' name='type' />
          </div>
          <div>
            {answers}
          </div>
          <div className='form-group'>
            <button type='submit' className='btn btn-primary' >New</button>
          </div>
        </form>
      </div>
    return template;
  }
});

React.render(<NewQuestion />, document.getElementById('new-question'));

