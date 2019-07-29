import {
  systemOs
} from '../config/env'
import Vue from 'vue'
import Router from 'vue-router'
import routerPc from './router.pc'
import routerWap from './router.wap'
const routerConfig = systemOs == 'pc' ? routerPc : routerWap;

// const c_systemOs = systemOs;
// const routerConfig = require('./router.' + c_systemOs).default;

Vue.use(Router)


export default new Router(routerConfig);
