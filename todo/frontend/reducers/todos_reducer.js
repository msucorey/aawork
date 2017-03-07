import {
  RECEIVE_TODOS,
  RECEIVE_TODO,
  REMOVE_TODO
} from "../actions/todo_actions";
import omit from 'lodash/omit';

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

const todosReducer = (state = initialState, action) => {
  switch(action.type) {
    case RECEIVE_TODOS:
      const newState = {};
      action.todos.forEach(todo => {
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      const newTodos = Object.assign({}, state.todos);
      newTodos[action.todo.id] = action.todo;
      return Object.assign({}, state, newTodos);
    case REMOVE_TODO:
      return omit(state, action.todo.id);
    default:
      return state;
  }
};

export default todosReducer;
