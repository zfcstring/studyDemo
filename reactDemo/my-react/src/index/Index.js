import React, { Component } from 'react';
import { Layout } from 'antd';
import './myIndex.css';
import Navs from '../navMenu/NavGradualOpacity'

// const {
//   Header, Footer, Sider, Content,
// } = Layout;
const {
  Footer, Sider, Content,
} = Layout;

// 声明一个类名为App的组件,调用组件<App />
class Myindex extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  componentDidMount() { // 挂载
  }

  componentWillUnmount() { // 卸载
  }

  render() {
    return (
      <div className="layout">
        <Layout>
          <Navs />
          <Layout>
            <Sider> Sider </Sider>
            <Content> Content </Content>
          </Layout>
          <Footer> Footer </Footer>
        </Layout>
      </div>
    );
  }
}

export default Myindex;
