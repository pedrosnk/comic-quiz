
var QuestionsList = React.createClass({
  componentDidMount: function(){
    $.ajax({ 'method' : 'GET',
      headers: { Accept: 'application/json' } }
    )
    .success(function(data){
      console.log(data);
    });
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
            <tr>
            </tr>
          </tbody>
        </table>
      </div>
    return template;
  }
});

React.render(<QuestionsList />, document.getElementById('table-container'));

