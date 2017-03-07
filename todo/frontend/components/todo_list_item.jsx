import React from 'react';
import TodoDetailViewContainer from './todo_list/todo_detail_view_container';

class TodoListItem extends React.Component {

  constructor(props) {
    super(props);
    this.state = { detail: false };

    this.handleClickDone = this.handleClickDone.bind(this);
    this.handleClickTitle = this.handleClickTitle.bind(this);
  }

  handleClickDone() {
    const newDone = { done: (this.props.todo.done ? false : true) };
    const flippedTodo = Object.assign({}, this.props.todo, newDone );
    this.props.receiveTodo(flippedTodo);
  }

  handleClickTitle() {
    this.setState({ detail: !this.state.detail });
  }

  render() {
    const { todo } = this.props;
    const buttonText = (this.props.todo.done ? "Undo" : "Done");
    let detail = "";
    if (this.state.detail) {
      detail = <TodoDetailViewContainer todo={todo} removeTodo={this.props.removeTodo}/>;
    }
    return (
      <li>
        <h3 onClick={this.handleClickTitle}>{todo.title}</h3>
        <button
          type="button"
          onClick={this.handleClickDone}>
          {buttonText}
        </button>
        {detail}
      </li>
    );
  }
}

export default TodoListItem;
