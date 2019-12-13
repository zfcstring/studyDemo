import React, { Component } from 'react';
import './NavGradualOpacity.css';

// 声明一个头部导航栏
class NavHeader extends Component {
  constructor(props) {
    super(props);
    this.nav = React.createRef();
    this.handMouseScroll = this.handMouseScroll.bind(this);
    this.state = {
      maxYOffset: 20, // 定义最大Y轴偏移量,超过则隐藏nav
    };
  }
  componentDidMount() { // 挂载
    if (window.addEventListener) {
      // IE9, Chrome, Safari, Opera
      window.addEventListener('mousewheel', this.handMouseScroll);
      window.addEventListener('mousedown', this.handMouseScroll);
      window.addEventListener('mouseup', this.handMouseScroll);
      // Firefox
      window.addEventListener('DOMMouseScroll', this.handMouseScroll);
    } else window.attachEvent('onmousewheel', this.handMouseScroll);
    // IE 6/7/8
  }
  
  componentWillUpdate() { // 状态更新前
  }
  componentDidUpdate() { // 状态更新后
  }

  componentWillUnmount() { // 卸载
  }

  handMouseScroll(e) {
    console.log(e); // e.wheelDeltaY > 0 向上;e.wheelDeltaY < 0 向下
    console.log(window.pageYOffset, this.state.maxYOffset);
    if (window.pageYOffset >= this.state.maxYOffset) { // 页面偏移量为参考
      this.nav.current.style.animationName = 'navTohide';
    } else {
      this.nav.current.style.animationName = 'navToshow';
    }
  }
  render() {
    console.log(window);
    return (
      <div ref={this.nav} className="nav-graopa">
      </div>
    );
  }
}

export default NavHeader;
