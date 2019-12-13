import React, { Component } from 'react';
import './Fivechess.css';

// 声明一个类名为App的组件,调用组件<App />
class MouseClick extends Component {
  constructor(props) {
    super(props);
    this.handleMouseEvent = this.handleMouseEvent.bind(this);
    this.state = {
      x : 0,
      y : 0
    };
  }

  handleMouseEvent(e) {
    this.setState({
      x: e.clientX,
      y: e.clientY
    })
  }

  render() {
    return (
      <div className="App" onClick={this.handleMouseEvent}>
        {this.props.mouseClient(this.state)}
      </div>
    );
  }
}

export default MouseClick;
