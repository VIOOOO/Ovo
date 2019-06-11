// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import 'framework7/css/framework7.css';
import Vue from 'vue'
import VueResource from 'vue-resource'
import IndexPage from './index'

import x2js from 'x2js' //xml数据处理插件
Vue.prototype.$x2js = new x2js() //创建x2js对象，挂到vue原型上

import Framework7 from 'framework7';
import Searchbar from 'framework7/components/searchbar/searchbar.js';
import Calendar from 'framework7/components/calendar/calendar.js';
import Popup from 'framework7/components/popup/popup.js';
Framework7.use([Searchbar, Calendar, Popup]);
Vue.use(VueResource,Framework7)
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<IndexPage/>',
  components: { IndexPage }
})
