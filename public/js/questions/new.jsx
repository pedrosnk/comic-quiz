
var AnswerField = React.createClass({
  uncheckOthers: function(ev){
    if(ev.target.checked){
      $('.answer-correct-field').each(function(i, elem){
        if(elem !== ev.target){
          elem.checked = false;
        }
      });
    }
  },
  render: function(){
    var inputNameText = '[answers]['+this.props.answerNum+'][text][en]'
    var inputNameCorrect = '[answers]['+this.props.answerNum+'][correct]'
    var template =
      <div className='form-group'>
        <label>Answer {this.props.answerNum + 1} </label>
        <input type='text' className='form-control' name={inputNameText} />
        <div className='checkbox'>
          <label>
            <input type='checkbox' onChange={this.uncheckOthers}
              className='answer-correct-field' name={inputNameCorrect} /> Correct Answer
          </label>
        </div>
      </div>
    return template;
  }
});

var NewQuestion = React.createClass({
  submitForm : function(e) {
    if($('.answer-correct-field:checked').length === 0){
      e.preventDefault();
    }
  },
  render : function(){
    var answers = _.map([0,1,2,3], function(n){
      return <AnswerField key={n} answerNum={n} />
    });

    var template =
      <form className='form' onSubmit={this.submitForm} method='POST' action='/questions' >
        <div className='row'>
          <h2>New Question</h2>
        </div>
        <div className='col-lg-6'>
          <div className='form-group'>
            <label htmlFor='textField'>Text</label>
            <textarea id='textField' className='form-control' name='[text][en]' />
          </div>
          <div className='form-group'>
            <label htmlFor='typeField'>Type</label>
            <input id='typeField' className='form-control' name='type' value='correctOne' readOnly/>
          </div>
          <div>
            {answers}
          </div>

          <div className='form-group'>
            <button type='submit' className='btn btn-primary' >New</button>
          </div>
        </div>
        <div className='col-lg-6'>
          <div className='form-group'>
            <label>Publisher</label>
            <select className='form-control' name='[meta][publisher]'>
              <option value='marvel'>Marvel</option>
              <option value='dc'>DC</option>
            </select>
          </div>
        </div>
      </form>
    return template;
  }
});

React.render(<NewQuestion />, document.getElementById('new-question'));

