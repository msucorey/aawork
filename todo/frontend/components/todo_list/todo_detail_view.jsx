import React from 'react';
import StepListContainer from '../step_list/step_list_container';
import StepForm from '../step_list/step_form';

class TodoDetailView extends React.Component {

  constructor (props) {
    super(props);
    this.handleClickDel = this.handleClickDel.bind(this);
  }

  handleClickDel() {
    this.props.removeTodo(this.props.todo);
  }

  render() {
    return (
      <div>
        <p>{this.props.todo.body}</p>
        <StepListContainer todoId={this.props.todo.id} />
        <StepForm
          receiveStep={this.props.receiveStep}
          todoId={this.props.todo.id}/>
        <button type="button" onClick={this.handleClickDel}>Delete</button>
      </div>
    );
  }
}

export default TodoDetailView;
