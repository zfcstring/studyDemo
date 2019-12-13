import React, { Component } from 'react';
import Chessboard from './ChessBoard'
import './Fivechess.css';

// 声明一个类名为App的组件,调用组件<App />
class Fivechess extends Component {
  constructor(props) {
    super(props);
    this.getMouseClient = this.getMouseClient.bind(this);
    this.state = {
      clientX: 0,
      clientY: 0,
      msg: `步1: player1下棋! `,
      winer: {}
    }
  }

  getMouseClient(gamestatus) {
    this.setState({
      clientX: gamestatus.clientX,
      clientY: gamestatus.clientY,
      msg: gamestatus.msg,
      winer: gamestatus.winer
    });
  }

  render() {
    return (
      <div className="App">
        <Chessboard mouseClientChange={this.getMouseClient}/>
        <div>
          <button>重开</button>
          <p>{this.state.msg}</p>
        </div>
      </div>
    );
  }
}

export default Fivechess;
