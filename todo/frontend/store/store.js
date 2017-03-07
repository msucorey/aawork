import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';

const Store = createStore(rootReducer);

export default Store;
