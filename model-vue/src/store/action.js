import service from '../service'

import TYPES from './mutation-types'

// import wsCache from 'web-storage-cache'

const globalError = (data, commit, command = {}) => {
    /**
     * APP 内查看网络接口状况 要隐藏查接口的reject(data);
     */
    // alert(`错误问题：${data.message}`)
    // alert(`状态码：${data.response ? data.response.status : "无"}`)
    // alert(`method：${data.config.method}; 接口：${data.config.url}`)

    /**
     * 自动异常处理
     */
    if (data && data.FailedMessage == "InternalServerError" && command.cmd != 'balance') {
        commit(TYPES.ALERT_TIP, {
            show: true,
            content: "服务异常，请联系在线客服。"
        })
    }
    // else if (data && command.cmd != 'balance' && (data.Data == "玩家不存在." || data.Data == "Error.Auth.MissingAuthToken" || data.FailedMessage == "Error.Auth.MissingAuthToken")) {
    //     if (systemOs == 'pc') {
    //         commit(TYPES.ALERT_TIP, {
    //             show: true,
    //             content: "由于长期未操作/账号有重复登录，请重新登录。",
    //             close: false,
    //             ok: true,
    //             oktext: "重新登录",
    //             success: () => {
    //                 commit(TYPES.USER_INFO_CLEAN)
    //                 window.location.reload();
    //             }
    //         })
    //     } else {
    //         if (data.Data == "Error.Auth.MissingAuthToken") {
    //             data.Data = "由于长期未操作/账号有重复登录，请重新登录。";
    //         }
    //         //移动端直接打开登录框
    //         commit("WapLogin", true);
    //     }
    //     /**
    //      * clean
    //      */
    //     commit(TYPES.USER_INFO_CLEAN)
    //     //}
    // } else if (data && data.FailedMessage && command.cmd != 'balance') {
    //     if (data.FailedMessage == "event.notBeginOrEnded") data.textFailedMessage = "不在活动时间";
    //     else if (data.FailedMessage == "event.depositDays.notMatch")
    //         data.textFailedMessage = "您上月累计包包天数未达标，不能领取免费彩金哦";
    //     else if (data.FailedMessage == "event.betAmount.notEnough")
    //         data.textFailedMessage = "您上月累计投手未达标，不能领取免费彩金哦";
    //     else if (data.FailedMessage == "event.notExists") data.textFailedMessage = "活动不存在";
    //     else if (data.FailedMessage == "event.hasJoined") data.textFailedMessage = "您已领取过该红利，不能贪心哦";
    //     else if (data.FailedMessage == "needfirstcash") data.textFailedMessage = "请先包包再参加该活动";
    //     else if (data.FailedMessage == "needverifyphone") data.textFailedMessage = "请进行手机验证后再来领取!";
    //     else if (data.FailedMessage == "event.notBegin") data.textFailedMessage = "活动还未开始!";
    //     else if (data.FailedMessage == "event.Ended") data.textFailedMessage = "活动已结束!";
    //     commit(TYPES.ALERT_TIP, {
    //         show: true,
    //         content: data.textFailedMessage || data.FailedMessage
    //     })
    // } else if (data && data.Data && command.cmd != 'balance') {
    //     commit(TYPES.ALERT_TIP, {
    //         show: true,
    //         content: data.Data
    //     });
    // } else {
    //     if (command.cmd != 'balance') {
    //         if (data.response && data.response.status&& data.response.status != 500) {
    //             //服务器异常
    //             commit(TYPES.ALERT_TIP, {
    //                 show: true,
    //                 content: `服务器繁忙，请稍后重试（${data.response.status}）`,
    //                 ok: true,
    //                 oktext: "立即联系",
    //                 closetext: "稍后联系",
    //                 success: () => {
    //                     if (isiOS) {
    //                         window.jumpLink(`${clientContact}`, "_default", null, "PORTRAIT");
    //                     } else {
    //                         window.jumpLink(`${clientContact}`, "_system", null, "PORTRAIT");
    //                     }
    //                 },
    //             })
    //             return true;
    //         }

    //         if (!window.navigator.onLine) {
    //             //用户网络异常
    //             commit(TYPES.ALERT_TIP, {
    //                 show: true,
    //                 content: `网络不给力呀！<br/>请检查下网络设置吧~`,
    //                 ok: true,
    //                 oktext: "重新连接",
    //                 success: () => {
    //                     window.location.reload();
    //                 },
    //             })
    //             return true;
    //         }
    //     }
    // }
}

export default {
    /** 
     * 登录
     */
    [TYPES.USER_LOGIN_IN]({
        // dispatch,
        commit,
        // state
    }, argsJson) {
        return new Promise(function(resolve, reject) {
            new service.MemberLogin(argsJson.array).then(data => {
                commit(TYPES.USER_INFO_SET, data)
                //刷新钱包
                // dispatch(TYPES.MEMBER_GET_BALANCE);
                /**
                 * callback success
                 */
                resolve(data)
            }, data => {
                reject(data);
                globalError(data, commit)
            });
        })
    },
    /**
     * 首页轮播图 
     * */
    [TYPES.BANNER_GET]({
        commit,
        // state
    }, argsJson = {}) {
        return new Promise(function(resolve, reject) {
            /**
             * cache get
             */
            // let cache = new wsCache();
            // const key = "getBanner" + JSON.stringify(argsJson.array)
            // const data = cache.get(key);
            // if (data && openCache) {
            //     /**
            //      * mutations state
            //      */
            //     commit(TYPES.BANNER_SET, data)
            //     /**
            //      * use cache to callback success
            //      */
            //     resolve(data)
            // }
            //else {
            new service.getBanner(argsJson.array).then(data => {
                /**
                 * cache set,3000000 sec
                 */
                // if (data.length) cache.set(key, data, {
                //     exp: 3000000
                // });
                /**
                 * mutations state
                 */
                commit(TYPES.BANNER_SET, data)
                /**
                 * use ajax to callback success
                 */
                resolve(data)
            }, data => {
                globalError(data, commit, { cmd: 'balance' });
                reject(data);
            });
            //}
        })
    },
}