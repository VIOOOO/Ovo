import service from '../service'

import TYPES from './mutation-types'

import wsCache from 'web-storage-cache'

import {
    openCache,
    isApp,
    isPc,
    systemOs,
    isiOS,
    clientContact
} from '@/config/env'

/**
 * 支付方式列表
 */
import deposit from "@/data/deposit";

let timer_balance = null;
const globalError = (data, commit, command = {}) => {
    if (data.StatusCode == 500) {
        return
    }
}


export default {
    [TYPES.LOGINWITHCODE]({
        commit,
        state
    }, argsJson) {
        return new Promise(function (resolve, reject) {
            new service.LoginWithCode(argsJson.array).then(data => {
                /**
                 * callback success
                 * 
                 */
                resolve(data)
                commit("UserInfo", data)
                /**
                 * 刷新余额
                 * 
                 */
                // new service.MemberGetBalance().then(res => {
                //     commit(TYPES.MEMBER_SET_BALANCE, res)
                // })
            }, data => {
                globalError(data, commit);
                reject(data);
            })
        });
    },

}