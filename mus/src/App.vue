<template>
  <div id="app">
      <!-- 头部header 固定-->
    <v-header></v-header>
    <!-- APP主体body -->
    <v-body></v-body>  
    <!-- APP底部footer 固定 -->
    <v-footer></v-footer>
  </div>
</template>

<script>
  import header from './components/header/header'
  import footer from './components/footer/footer'
  import body from './components/index/index'
  import Vue from 'vue'
  import axios from 'axios'
  import Vueaxios from 'vue-axios'
  import store from './store'

export default {
    name: 'App',
    components:{
     'v-header':header,
     'v-footer':footer,
     'v-body':body
    },
    created () {
       let LocalAPI='static/data.json';
       axios.get(LocalAPI).then((res) => {
    // data.user的信息赋值给info  再通过组件的数据传递传给sideBar
        this.info = res.data.music
    // 把所有的音乐数据给vuex的musicAllList
        store.dispatch('set_MusicAllList', res.data.music)
       })
   }
}
</script>
  

<style >
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
