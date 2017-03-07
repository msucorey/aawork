import React from 'react';
import ReactDOM from 'react-dom';
import Root from './components/root';

import store from './store/store';
import { receiveTodos, receiveTodo } from './actions/todo_actions';
import { receiveSteps, receiveStep, removeStep } from './actions/step_actions';
import { allTodos, stepsByTodoId } from './reducers/selectors';

window.store = store;
window.receiveTodos = receiveTodos;
window.receiveTodo = receiveTodo;
window.allTodos = allTodos;
window.stepsByTodoId = stepsByTodoId;
window.receiveStep = receiveStep;
window.receiveSteps = receiveSteps;
window.removeStep = removeStep;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root store={store} />, document.getElementById('main'));
});
