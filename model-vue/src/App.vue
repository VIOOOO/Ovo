<template>
    <div id="app">
        <img alt="Vue logo" src="./assets/logo.png">
        <HelloWorld msg="Welcome to Your Vue.js App" />
    </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
// import TYPES from "./store/mutation-types";
import { mapGetters } from "vuex";
export default {
    name: 'app',
    components: {
        HelloWorld
    },
    computed: mapGetters(["userInfo","banners"]),
    created(){
        this.$_userData()
    },
    methods: {
        $_userData() {
            const that = this;
            // that.$store.commit(TYPES.USER_INFO_INIT);
            return that.$store
        }
    }
}
</script>

<style>
#app {
    font-family: "Avenir", Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}
</style>
