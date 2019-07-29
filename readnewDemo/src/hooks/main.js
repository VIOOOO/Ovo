import { isApp, isPc, systemOs, isiOS, clientContact, serverUrl, cookie, clearUser, restoreLogin } from '@/config/env'
import TYPES from '@/store/mutation-types'

const globalError = (data, commit, command = {}) => {

}
export default {

    beforePromise(p) {
        const loginDataInfo = cookie.getJSON('UserInfo');
        if (!p.param) {
            if (loginDataInfo) {
                p.param = { "tempkey": loginDataInfo.userName }
            } else {
                p.param = { "tempkey": "cacheweb" }
            }
        } else {
            p.param.tempkey = loginDataInfo ? loginDataInfo.userName : "cacheweb";
        }
    },
    beforeAxios(p) {
        if (p.axios) {
            /**
             * 30 分钟没请求接口，就自动退出到首页
             */
            // restoreLogin();

            p.axios.baseURL = serverUrl;
            // p.param = 
            let arr = [];
            //接口请求参数转格式 application/x-www-form-urlencoded;charset=UTF-8
            // if(p.param && p.axios.method.toUpperCase() == "GET"){
            //     for(let key in p.param){
            //         arr.push(`${key}=${p.param[key]}`)
            //     }
            //     p.param = arr.join("&");
            // }
            if (p.axios.method.toUpperCase() == "POST" && p.axios.data) {
                for (let key in p.axios.data) {
                    arr.push(`${key}=${p.axios.data[key]}`)
                }
                p.axios.data = arr.join("&");
            }

            if (p.state.Login) {
                if (!p.axios.headers) {
                    p.axios.headers = {}
                }
                p.axios.headers["Authorization"] = "Bearer " + p.state.Login;
            }
        }
    },
    afterAxios(p) {
        if (p.data.StatusCode == 500) {
            // 所有500 报错不提示
            // globalError(p.data, window.$local.vm.$store.commit);
            return false;
        }
        // else {
        //     try {
        //         if (typeof JSON.parse(p.data.data) == "object") {
        //             p.data = JSON.parse(p.data.data)
        //         }
        //     } catch (e) {
        //         p.data = p.data.data
        //     }
        // }
    },
    beforeVuex(p) {

    },
    afterVuex(p) {

    },
    netError(p) {
        // if (p.data.response.status == 400 || p.data.response.status == 401) {
        //     const loginData = cookie.getJSON('UserLogin');
        //     if (loginData) {
        //         cookie.remove('UserLogin');
        //     }
        // }

        // if (p.data.response.status == 400) {

        //     for (var key in p.data.response.data);
        //     if (key) {
        //         globalError({
        //             failedMessage: p.data.response.data[key][0]
        //         }, window.$local.vm.$store.commit);
        //     } else {
        //         globalError({
        //             failedMessage: `网络错误${p.data.response.status}`
        //         }, window.$local.vm.$store.commit);
        //     }
        // } else {
        //     globalError({
        //         failedMessage: `网络错误${p.data.response.status}`
        //     }, window.$local.vm.$store.commit);
        // }
        // return false;
    }

}