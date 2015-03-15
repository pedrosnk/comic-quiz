
var NewQuestion = React.createClass({
  render : function(){
    var template =
      <div className='col-lg-6'>
        <h2>New Question</h2>
        <form className='form'>
          <div className='form-group'>
            <label for='textField'>Text</label>
            <input id='textField' className='form-control' name='text' />
          </div>
          <div className='form-group'>
            <label for='typeField'>Type</label>
            <input id='typeField' className='form-control' name='type' />
          </div>
        </form>
      </div>
    return template;
  }
});

React.render(<NewQuestion />, document.getElementById('new-question'));

