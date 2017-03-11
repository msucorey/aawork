import * as APIUtil from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const LOGOUT_USER = 'LOGOUT_USER';
export const RECEIVE_ERRORS = 'RECEIVE_ERRORS';
export const RECEIVE_LOGOUT_SUCCESS = 'RECEIVE_LOGOUT_SUCCESS';

//async actions
export const requestSignup = user => dispatch => {
  return APIUtil.newUser(user).then(
    currentUser => dispatch(receiveCurrentUser(currentUser))
  ).fail(
    error => dispatch(receiveErrors(error.responseJSON))
  );
};

export const requestLogin = user => dispatch => {
  return APIUtil.newSession(user).then(
    currentUser => dispatch(receiveCurrentUser(currentUser))
  ).fail(
    error => dispatch(receiveErrors(error.responseJSON))
  );
};

export const requestLogout = () => dispatch => {
  return APIUtil.deleteSession().then(
    () => dispatch(receiveLogoutSuccess())
  );
};

//sync actions
export const receiveCurrentUser = currentUser => ({
  type: RECEIVE_CURRENT_USER,
  currentUser
});

export const receiveErrors = errors => ({
  type: RECEIVE_ERRORS,
  errors
});

export const receiveLogoutSuccess = () => ({
  type: RECEIVE_LOGOUT_SUCCESS
});

// Before we get to the reducer, let's write and export the following action creators in a new file actions/session_actions.js:
//
// login(user) (thunk action creator)
// logout() (thunk action creator)
// signup(user) (thunk action creator)
// receiveCurrentUser(currentUser) (regular action creator)
// receiveErrors(errors) (regular action creator)
// Don't forget to define and export the corresponding action types as well (e.g., export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER').
//
// logout won't accept an argument. receiveErrors will take an array. All other action creators accept a user object. On logout success dispatch receiveCurrentUser(null) to remove the current user.
