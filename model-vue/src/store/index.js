import Vue from 'vue'
import Vuex from 'vuex'
import mutations from './mutations'
import actions from './action'
import getters from './getters'
import state from './state'

Vue.use(Vuex)

export default new Vuex.Store({
    state: Object.assign({}, state),
    getters: Object.assign({}, getters),
    actions: Object.assign({}, actions),
    mutations: Object.assign({}, mutations)
})