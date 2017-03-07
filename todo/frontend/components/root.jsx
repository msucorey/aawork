import React from 'react';
import { Provider } from 'react-redux';
import App from './app';
// import { receiveTodos, receiveTodo } from '../actions/todo_actions';
// import { allTodos } from '../reducers/selectors';
//TODO import container

const Root = ({ store }) => (
  <Provider store={ store }>
    <App />
  </Provider>
);

export default Root;
