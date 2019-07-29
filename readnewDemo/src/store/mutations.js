import Vue from 'vue'
import TYPES from './mutation-types'

import {setStore, getStore } from '../config/mUtils'

import {localapi, proapi, json2KeyValue,keyValue2Json} from '../config/env'
import jsCookie from 'js-cookie'
const cookie = jsCookie.withConverter({
    read: function(value, name) {
        return value;
    },
    write: function(value, name) {
        return value;
    }
});
export default {

    [TYPES.MENU_INFO_INIT](state) {
        // 以cookie为准
        const menuInfo = cookie.getJSON('menu');
        state.menuInfo = menuInfo;
    },
    [TYPES.MENU_INFO_SET](state, dataString) {
        state.menuInfo = dataString;
        cookie.set('menu', dataString, {
            path: '/'
        });
    },
    [TYPES.ALERT_TIP](state, dataJson) {
        state.alert = Object.assign({}, state.alert, dataJson);
    },
    [TYPES.CUSTOMALERTTIP](state, dataJson) {
        state.CustomAlertTip = Object.assign({}, state.CustomAlertTip, dataJson);
    },
    // [TYPES.USERINFO](state, dataJson) {
    //     state.UserInfo = Object.assign({}, state.UserInfo, dataJson);
    // },
    
}