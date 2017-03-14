// frontend/reducers/root_reducer.jsx

import { combineReducers } from 'redux';

import benchesReducer from './benches_reducer';
import SessionReducer from './session_reducer';

const RootReducer = combineReducers({
  benches: benchesReducer,
  session: SessionReducer
});

export default RootReducer;
