import { merge } from 'lodash';

import {
  RECEIVE_CURRENT_USER,
  RECEIVE_ERRORS
} from '../actions/session_actions';

const defaultState = {
  currentUser: null,
  errors: []
};

const SessionReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      return ({
        currentUser: action.currentUser,
        errors: []
      });
    case RECEIVE_ERRORS:
      const errors = { errors: action.errors };
      return merge({}, state, errors);
    default:
      return state;
  }
};

export default SessionReducer;

// The SessionReducer should listen for 2 action types and respond to each like so:
//
// RECEIVE_CURRENT_USER - sets currentUser to the action's user and clears errors
// RECEIVE_ERRORS - sets errors to the action's errors and clears the currentUser
// Your SessionReducer should maintain its own default state. To do that pass in an object as a default argument to SessionReducer with currentUser set to null and errors set to an empty array.
//
// Remember to use both Object.freeze() and Object.assign or lodash/merge to prevent the state from being accidentally mutated.
