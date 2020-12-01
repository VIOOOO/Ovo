import 'es6-promise/auto'
// import myvue from './myvue'

import Vue from 'vue'
import App from './App'
new Vue({
  render: h => h(App),
}).$mount('#app')

// myvue();