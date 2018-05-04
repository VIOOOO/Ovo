import Vue from 'vue'
import Vuex from 'vuex'

// import MusicList from './modules/musiclist.js'


Vue.use(Vuex)

const store = new Vuex.Store({
    state:{
        commit:1,
        musicAllList:[]
    },
    getters:{
        // 获取音乐全部信息
        getMusicAllList: state => state.musicAllList
    },
    mutations:{
        setMusicAllList (state, obj) {
			state.musicAllList = obj;
            state.musicList = obj.all;
        }
        
    },
    actions:{
        set_MusicAllList ({commit}, obj) {
			commit('setMusicAllList', obj)
		}
    }
})

export default store;