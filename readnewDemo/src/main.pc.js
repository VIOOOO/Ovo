// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
// import 'html5-history-api'

import 'es6-promise/auto'
import {
    siteTheme,
    buildImg,
    addEvent
} from './config/env'
document.title = "佣金方案 - 加盟合作 - 天宇官方网站";


//pc端删除meta值
// let head = document.getElementsByTagName('head')[0], nodes = head.childNodes, node, i = 0;
// while (node = nodes[i++]) {
//     if(node.nodeType == 1 && node.tagName.toLowerCase() == 'meta' && node.getAttribute('name') == 'viewport'){
//         node.setAttribute('content','');
//     }
// }

import './fonts/iconfont/iconfont.css';

import Vue from 'vue'
import VueRouter from 'vue-router'
import routerConfig from './router/router.pc'
import App from './App'
require('./assets/pc/css/layout.css')
require('./assets/pc/css/theme.heji.css')
import SmoothPicker from 'vue-smooth-picker'
import Datetime from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'
Vue.use(Datetime)

Vue.use(VueRouter)
let router = new VueRouter(routerConfig);
import myvue from './myvue'
myvue(router,App);