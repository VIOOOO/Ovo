import { isApp, serverUrl, restoreLogin } from '@/config/env'

export default {

    beforePromise(p) {},
    beforeAxios(p) {
        if (p.axios) {
            /**
             * 30 分钟没请求接口，就自动退出到首页
             */
            restoreLogin()

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
        if (p.data.passed) {
            try {
                if (typeof JSON.parse(p.data.data) == "object") {
                    p.data = JSON.parse(p.data.data)
                }
            } catch (e) {

            }
        }
    },
    beforeVuex(p) {

    },
    afterVuex(p) {

    },
    netError(p) {
        if (p.data.response.status == 400) {
            for (var key in p.data.response.data);
            globalError({
                failedMessage: p.data.response.data[key][0] + p.data.response.status
            }, window.$local.vm.$store.commit);
        } else {
            console.log(p)
            globalError({
                failedMessage: `网络错误 ${p.data.response.status}`
            }, window.$local.vm.$store.commit);
        }
        return false;
    }
}