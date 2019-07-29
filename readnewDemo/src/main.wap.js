// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
// import 'html5-history-api'

import 'es6-promise/auto'
import {
    siteTheme,
    isApp
} from './config/env'
import './config/update'
document.title = siteTheme.alias + '官方网站 ' + location.host;
import './config/rem'
import './assets/wap/css/master.css';



import 'framework7/dist/css/framework7.css';
import './fonts/iconfont/iconfont.css';

// Import Vue
import Vue from 'vue';





// Import F7
// import Framework7 from 'framework7/dist/framework7.esm.bundle.js';
import Framework7 from 'framework7';
import preloader from 'framework7/dist/components/preloader/preloader.js';
import link from 'framework7/dist/components/link/link.js';
import subnavbar from 'framework7/dist/components/subnavbar/subnavbar.js';
import navbar from 'framework7/dist/components/navbar/navbar.js';
import page from 'framework7/dist/components/page/page.js';
import list from 'framework7/dist/components/list/list.js';
import toolbar from 'framework7/dist/components/toolbar/toolbar.js';
import swiper from 'framework7/dist/components/swiper/swiper.js';
import block from 'framework7/dist/components/block/block.js';
import view from 'framework7/dist/components/view/view.js';
import panel from 'framework7/dist/components/panel/panel.js';
import notification from 'framework7/dist/components/notification/notification.js';
import popup from 'framework7/dist/components/popup/popup.js';
Framework7.use([preloader, link, subnavbar, navbar, page, list, toolbar, swiper, block, view, panel, notification, popup]);

// Import F7 Vue Plugin
import Framework7Vue from 'framework7-vue/dist/framework7-vue.esm.bundle.js';



// Import App Custom Styles
// import './assets/wap/fonts/iconfont/iconfont.css'

import App from './App2'
import router from './router/router.wap'

// Init F7 Vue Plugin
Vue.use(Framework7Vue, Framework7)

import 'vue-smooth-picker/dist/css/style.css'
import SmoothPicker from 'vue-smooth-picker'

// 滑动触摸
import touch from 'vue-directive-touch';

// 添加Swiper
// import VueAwesomeSwiper from 'vue-awesome-swiper'
// import 'swiper/dist/css/swiper.css'
// Vue.use(VueAwesomeSwiper)
// 添加Swiper结束

Vue.use(SmoothPicker)
Vue.use(touch);

require('./assets/wap/css/layout.css')
require('./assets/wap/css/theme.heji.css')


import myvue from './myvue'
myvue(router, App);