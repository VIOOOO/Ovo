import { serverUrl, isApp, keyValue2Json, clearUser } from './env'
import axios from 'axios';
import cookie from "js-cookie";
let timer = null;

export default (url = '', data = {}, type = 'POST', method = 'fetch') => {


    /**
     * 30 分钟没请求接口，就自动退出到首页
     */
    // if (timer) {
    //     timer = clearTimeout(timer)
    // }
    // timer = setTimeout(function() {
    //     //clearUser()
    //     // cookie.remove('UserLogin');
    //     window.location.reload()
    // }, 30 * 60 * 1000);
    // if (isApp) {
    //     
    //     const token = cookie.get('authToken');
    //     if(token){
    //         const d = serverUrl.replace('https://', '').replace('http://', '').replace('/', '') + '1111';
    //         cookie.set('authToken', token, {
    //             Domain: d
    //         });
    //     }
    // }
    // if(isApp){
    //     const userInfo = keyValue2Json(cookie.getJSON('UserLogin'));
    //     if(userInfo){
    //         if(data instanceof Array){
    //             data.push({ key: "authToken", value: userInfo.authtoken })
    //         }
    //         else{
    //             data.authToken = userInfo.authtoken
    //         }
    //     }
    // }

    return new Promise((resolve, reject) => {
        axios({
                method: type.toUpperCase(),
                url: serverUrl + url,
                data: JSON.stringify(data),
                withCredentials: true,
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then(function(response) {
                let data = response.data;
                if (data && typeof data !== 'object') {
                    data = JSON.parse(data);
                }
                resolve(data)
            })
            .catch(function(error) {
                reject(error)
            });
    });
}