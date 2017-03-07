export const allTodos = state => {
  return Object.keys(state.todos).map(id => state.todos[parseInt(id)]);
};

export const stepsByTodoId = (state, todoId) => {
  const allSteps = Object.keys(state.steps).map(id => state.steps[parseInt(id)]);
  return allSteps.filter(step => step.todo_id === todoId);
};
