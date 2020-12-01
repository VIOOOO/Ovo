import Vue from 'vue'
import store from './store'
Vue.config.productionTip = false

/**
 * 全局捕获错误
 */
// window.onunhandledrejection = function (data) {
//     console.log(data)
// }



const myvue = async (router, App) => {
    let myVm = new Vue({
        el: '#app',
        store,
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
        vm: myVm
    }

    return myVm;
}
export default myvue;
