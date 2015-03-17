
var QuestionsList = React.createClass({
  componentDidMount: function(){
    $.ajax({ 'method' : 'GET',
      headers: { Accept: 'application/json' } }
    )
    .success(function(data){
      this.setState({questions: data});
    }.bind(this));
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
                         <a className='btn btn-danger btn-sm'>Delete</a>
                       </td>
                     </tr>
            })}
          </tbody>
        </table>
      </div>
    return template;
  }
});

React.render(<QuestionsList />, document.getElementById('table-container'));

