import { connect } from 'react-redux';
import StepListItem from './step_list_item';
// import { stepsByTodoId } from '../../reducers/selectors';
// import { removeTodo } from '../../actions/todo_actions';
import { receiveStep, removeStep } from '../../actions/step_actions';

const mapDispatchToProps = dispatch => ({
  receiveStep: step => dispatch(receiveStep(step)),
  removeStep: step => dispatch(removeStep(step))
});

export default connect(
  null,
  mapDispatchToProps
)(StepListItem);
