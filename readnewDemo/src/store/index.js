import Vue from 'vue'
import Vuex from 'vuex'
import mutations from './mutations'
import actions from './action'
import getters from './getters'
import state from './state'
// const vax = require('../.vax.xml');
import vax from '../.vax.xml'
console.log(vax)
Vue.use(Vuex)
export default new Vuex.Store({
    state: Object.assign({}, state, vax.state),
    getters: Object.assign({}, getters, vax.getters),
    actions: Object.assign({}, actions, vax.actions),
    mutations: Object.assign({}, mutations, vax.mutations)
})