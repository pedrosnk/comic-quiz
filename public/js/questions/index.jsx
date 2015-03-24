
var QuestionsList = React.createClass({
  deleteQuestion: function(e){
    if( confirm('Are you sure?') ){
      var questionId = e.target.attributes['data-question-id'].value;
      $.ajax({  url: '/questions/' + questionId,
        method: 'delete',
        headers: { Accept: 'application/json' } }
      ).success(function(data){
        this.loadQuestions();
      }.bind(this));
    }
  },
  loadQuestions: function(){
    $.ajax({ 'method' : 'GET',
      headers: { Accept: 'application/json' } }
    ).success(function(data){
      this.setState({questions: data});
    }.bind(this));
  },
  componentDidMount: function(){
    this.loadQuestions();
  },
  getInitialState: function(){
    return {
      questions : []
    };
  },
  render: function(){
    var template =
      <div>
        <a href='/questions/new' className='btn btn-primary'>Novo</a>
        <table className='table'>
          <thead>
            <tr>
              <th>Question</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {this.state.questions.map(function(question){
              return <tr key={question._id}>
                       <td>{question.text.en}</td>
                       <td className='btn-group'>
                         <a className='btn btn-default btn-sm'>Edit</a>
                         <a className='btn btn-danger btn-sm' data-question-id={question._id}
                           onClick={this.deleteQuestion}>Delete</a>
                       </td>
                     </tr>
            }.bind(this))}
          </tbody>
        </table>
      </div>
    return template;
  }
});

React.render(<QuestionsList />, document.getElementById('table-container'));

