import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import 'antd/dist/antd.css';
// import App from './App';
// import Fivechess from './Firstapp/Fivechess';
import Myapp from './index/Index'
import * as serviceWorker from './serviceWorker';

ReactDOM.render(<Myapp />, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister();
