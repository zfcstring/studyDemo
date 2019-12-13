import React, { Component } from 'react';
import './Fivechess.css';

const player = [{
  name: 'player1',
  color: 'black',
  chesses: [],
  status: false
}, {
  name: 'player2',
  color: 'red',
  chesses: [],
  status: false
}]
let gamestatus = {
  clientX: 0,
  clientY: 0,
  msg: '',
  winer: {}
}
// 声明一个类名为App的组件,调用组件<App />
class Chessboard extends Component {
  constructor(props) {
    super(props);
    this.chessboard = React.createRef();
    this.chessbox = React.createRef();
    this.handleMouseEvent = this.handleMouseEvent.bind(this);
    this.state = {
      x: 0,
      y: 0
    };
  }

  componentDidMount() {
    const canv = this.chessboard.current
    canv.width = 800;
    canv.height = 600;
    drowChessBoard(canv);
  }

  handleMouseEvent(e) {
    const p = turnPlayer() ? player[0] : player[1];
    this.setState({ // 异步执行
      x: e.clientX,
      y: e.clientY
    }, () => {
      drowChesses(this.chessboard.current, this.state, p);
      this.props.mouseClientChange(gamestatus);
    });
    // console.log(this.state)
    // 此时this.state并没有更新,因为setState是异步执行
    // 需要在setState的第二参数回调或者在生命周期componentDidUpdate里调用更新的state
  }

  componentDidUpdate() { // 数据更新后会执行
  }

  render() {
    return (
      <div className="board" ref={this.chessbox}>
        <canvas ref={this.chessboard} onClick={this.handleMouseEvent}></canvas>
        {/* <p>x: {this.state.x}, y: {this.state.y}</p> */}
      </div>
    );
  }
}
// 画布
function getCanvas(ag) {
  const canv = ag;
  return canv.getContext('2d');
}
// 棋盘
function drowChessBoard(ag) {
  const cx = getCanvas(ag);
  cx.strokeStyle = '#ffc8c8'
  for (let i = 0; i <= 80; i++) {
    cx.moveTo(0, i*10);
    cx.lineTo(800, i*10);
    cx.stroke();
  }
  for (let i = 0; i <= 80; i++) {
    cx.moveTo(i*10, 0);
    cx.lineTo(i*10, 800);
    cx.stroke();
  }
}
// 下棋
function drowChesses(ag, client, p) {
  const x = Math.round((client.x - 20) / 10) * 10;
  const y = Math.round((client.y - 20) / 10) * 10;
  const curclient = {x: x, y: y};
  gamestatus.clientX = x;
  gamestatus.clientY = y;
  if (isHasChess(curclient)) { // 此处已有其他棋子
    gamestatus.msg = '此处已有其他棋子! ';
    return;
  } else if (player[0].status || player[1].status) { // 某玩家已赢
    return;
  } else {
    const cx = getCanvas(ag);
    cx.fillStyle = p.color;
    cx.beginPath();
    cx.arc(x, y, 5, 0, Math.PI*2, true);
    cx.closePath();
    cx.fill();
    p.chesses.push(curclient);
    const play = turnPlayer() ? player[0] : player[1];
    const num = player[0].chesses.length + player[1].chesses.length + 1;
    gamestatus.msg = `步${num}: ${play.name}下棋! `;
    isWin(curclient, p);
  }
}
// 轮流
function turnPlayer() { // true轮到玩家1, false轮到玩家二
  return player[0].chesses.length === player[1].chesses.length;
}
// 是否已经有棋子了
function isHasChess(client) {
  if (objIsInArr(client, player[0].chesses) || objIsInArr(client, player[1].chesses)) {
    return true;
  } else {
    return false;
  }
}
// 赢棋
function isWin(cli, p) {
  p.status = winByLine(cli, p) || winByRow(cli, p) || winBylefttop(cli, p) || winByrighttop(cli, p);
  if (p.status) {
    const winer = p.name + ' is win!';
    gamestatus.msg = winer;
    gamestatus.winer = p;
  }
}
// 横着赢——
function winByLine(cli, p) {
  let numadd = 0;
  let isadd = true;
  let numless = 0;
  let isless = true;
  for (let i = 1; i < 5; i++) {
    const objadd = {
      x: cli.x + 10*i,
      y: cli.y
    }
    const objless = {
      x: cli.x - 10*i,
      y: cli.y
    }
    if (isadd || isless){
      if (isadd && objIsInArr(objadd, p.chesses)) {
        numadd++;
      } else { isadd = false; }
      if (isless && objIsInArr(objless, p.chesses)) {
        numless++;
      } else { isless = false; }
    } else { break; }
  }
  if (numadd + numless >= 4) {
    return true;
  } else {
    return false;
  }
}
// 竖着赢 |
function winByRow(cli, p) {
  let numadd = 0;
  let isadd = true;
  let numless = 0;
  let isless = true;
  for (let i = 1; i < 5; i++) {
    const objadd = {
      x: cli.x,
      y: cli.y + 10*i
    }
    const objless = {
      x: cli.x,
      y: cli.y - 10*i
    }
    if (isadd || isless){
      if (isadd && objIsInArr(objadd, p.chesses)) {
        numadd++;
      } else { isadd = false; }
      if (isless && objIsInArr(objless, p.chesses)) {
        numless++;
      } else { isless = false; }
    } else { break; }
  }
  if (numadd + numless >= 4) {
    return true;
  } else {
    return false;
  }
}
// 斜着赢 /
function winByrighttop(cli, p) {
  let numadd = 0;
  let isadd = true;
  let numless = 0;
  let isless = true;
  for (let i = 1; i < 5; i++) {
    const objadd = {
      x: cli.x + 10*i,
      y: cli.y - 10*i
    }
    const objless = {
      x: cli.x - 10*i,
      y: cli.y + 10*i
    }
    if (isadd || isless){
      if (isadd && objIsInArr(objadd, p.chesses)) {
        numadd++;
      } else { isadd = false; }
      if (isless && objIsInArr(objless, p.chesses)) {
        numless++;
      } else { isless = false; }
    } else { break; }
  }
  if (numadd + numless >= 4) {
    return true;
  } else {
    return false;
  }
}
// 斜着赢 \
function winBylefttop(cli, p) {
  let numadd = 0;
  let isadd = true;
  let numless = 0;
  let isless = true;
  for (let i = 1; i < 5; i++) {
    const objadd = {
      x: cli.x + 10*i,
      y: cli.y + 10*i
    }
    const objless = {
      x: cli.x - 10*i,
      y: cli.y - 10*i
    }
    if (isadd || isless){
      if (isadd && objIsInArr(objadd, p.chesses)) {
        numadd++;
      } else { isadd = false; }
      if (isless && objIsInArr(objless, p.chesses)) {
        numless++;
      } else { isless = false; }
    } else { break; }
  }
  if (numadd + numless >= 4) {
    return true;
  } else {
    return false;
  }
}
// 判断一个数组是否包含某个对象
function objIsInArr(obj, arr) {
  for (const item of arr) {
    if (item.x === obj.x && item.y === obj.y) {
      return true;
    }
  }
  return false;
}

export default Chessboard;
