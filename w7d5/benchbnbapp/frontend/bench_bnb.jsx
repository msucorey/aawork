import { newUser, newSession, deleteSession } from './util/session_api_util';
import React from 'react';
import ReactDOM from 'react-dom';

window.newUser = newUser;
window.newSession = newSession;
window.deleteSession = deleteSession;

document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('root');
    ReactDOM.render(<h1>Welcome to BenchBnB</h1>, root);
});
