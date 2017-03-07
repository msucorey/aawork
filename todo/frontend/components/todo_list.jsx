import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_list/todo_form';

class TodoList extends React.Component {

  constructor (props) {
    super(props);
  }

  render() {
    const { todos } = this.props;
    const items = [];
    todos.forEach(todo => {
      items.push(<TodoListItem
        key={todo.id}
        todo={todo}
        removeTodo={this.props.removeTodo}
        receiveTodo={this.props.receiveTodo}
      />);
    });

    return (
      <div>
        <ul>
          {items}
        </ul>
        <TodoForm receiveTodo={this.props.receiveTodo}/>
      </div>
    );
  }
}

export default TodoList;
