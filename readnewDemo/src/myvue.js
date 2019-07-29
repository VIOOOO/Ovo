
import {
    systemOs,
    siteTheme,
    buildImg,
    addEvent,
    serverUrl,
    isApp,
    isWap,
    isPc,
    isAndroid
} from './config/env'
import Vue from 'vue'
import Vuelazyload from 'vue-lazyload'
import store from './store'
import FastClick from 'fastclick'
import TYPES from "@/store/mutation-types"
import { goPrize, jumpLink, lazyLoad } from './config/lazy'
// import jsCookie from 'js-cookie'


/**
 * 图片懒加载
 */
Vue.use(Vuelazyload, {
    loading: require('./assets/lazyload.jpg')
})
// 注册一个全局自定义指令 `v-focus`
Vue.directive('focus', {
  // 当被绑定的元素插入到 DOM 中时……
  inserted: function (el) {
    // 聚焦元素
    Vue.nextTick(() => el.focus());
  }
})


// 注册一个全局自定义指令 `v-inputprevent` 阻止表单中input的输入框默认提交表单
Vue.directive('inputprevent', {
    // 当被绑定的元素插入到 DOM 中时……
    inserted: function (el) {
      // 聚焦元素
        Vue.nextTick(() => {
            el.onkeydown = (event)=>{
                if(event.keyCode == 13){
                    el.blur();
                    return false;
                }
            }
        });
    }
  })

if ('addEventListener' in document && isAndroid) {
    document.addEventListener('DOMContentLoaded', function () {
        FastClick.attach(document.body);
    }, false);
}
Vue.config.productionTip = false
/**
 * 全局捕获错误
 */
window.onunhandledrejection = function (data) {
    // console.log(data)
}

const myvue = (router,App) => {
    /* eslint-disable no-new */

    let myVm = new Vue({
        el: '#app',
        provide: {
            alias: siteTheme.alias
        },
        router,
        store,   
        framework7: {
            id: 'io.framework7.testapp', // App bundle ID
            name: 'Framework7', // App name
            theme: 'ios', // Automatic theme detection
            // App routes
            routes: router
        },
        template: '<App/>',
        components: {
            App
        }
    })
    /**
     * 抛出全局变量
     */
    window.$local = {
        state: myVm.$store.state,
        vm: myVm,
        env:{
            isApp, 
            isWap,
            isPc
        }
    }

    /**
     * 抛出全局方法 
     * 2、goPrize 领取优惠
     * 3、jumpLink 跳转链接
     */
    window.goPrize = goPrize
    window.jumpLink = jumpLink

    /**
     * 组件预加载 https://www.reddit.com/r/vuejs/comments/7exvxi/preloading_a_codesplit_vue_component_before_its/
     */
    if (!isApp) {
        lazyLoad(router)
    }

    return myVm;
}
export default myvue;


