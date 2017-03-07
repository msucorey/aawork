import {
  RECEIVE_STEPS,
  RECEIVE_STEP,
  REMOVE_STEP
} from "../actions/step_actions";
import omit from 'lodash/omit';

const initialStepsState = {
  1: {
    id: 1,
    title: "walk to store",
    done: false,
    todo_id: 1
  },
  2: {
    id: 2,
    title: "buy soap",
    done: false,
    todo_id: 1
  }
};

const stepsReducer = (state = initialStepsState, action) => {
  switch(action.type) {
    case RECEIVE_STEPS:
      const newState = {};
      action.steps.forEach(step => {
        newState[step.id] = step;
      });
      return newState;
    case RECEIVE_STEP:
      const newSteps = Object.assign({}, state.steps);
      newSteps[action.step.id] = action.step;
      return Object.assign({}, state, newSteps);
    case REMOVE_STEP:
      return omit(state, action.step.id);
    default:
      return state;
  }
};

export default stepsReducer;
