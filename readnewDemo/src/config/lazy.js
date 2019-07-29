import { serverUrl, isApp,  isPc, isWap } from './env'
import TYPES from "@/store/mutation-types"
import base64 from "./base64"
/**
 * 抛出全局方法 
 * 2、goPrize 领取优惠
 * 3、jumpLink 跳转链接
 */

export const goPrize = (eventId, op = "", param = []) => {
    if (!$local.state.userInfo) {
        /**@description 未登录 */
        $local.vm.$store.commit(TYPES.ALERT_TIP, {
            show: true,
            content: "请先登录，再领取优惠。"
        });
    } else {
        // $local.vm.$store.dispatch(TYPES.APPLICATION_APPLY, {
        //     array: {
        //         eventId,
        //         op,
        //         param
        //     }
        // }).then(data => {
        //     $local.vm.$store.commit(TYPES.ALERT_TIP, {
        //         show: true,
        //         content: data
        //     });
        // });
    }
}

// PORTRAIT LANDSCAPE
export const jumpLink = (url, target, data, orientation = "LANDSCAPE", gameName) => {
    // target : _blank 表示用app打开
    // target : _system 表示用app内浏览器打开，url不可编辑
    // target : _default 表示用app内浏览器打开，url可编辑，如UC浏览器、谷歌浏览器、Safari浏览器
    // target : _router 表示通过路由跳转
    if (target == '_router') {
        if (isPc) {
            $local.vm._router.push(url);
        } else if (isWap || isApp) {
            $local.vm.$f7.view.main.router.navigate(url)
        }
        return;
    }
    if (isApp) {
        if (target == '_system') {
            window.open(url, "_blank");
        } else if (target == '_default') {
            if (data && Object.prototype.toString.call(data) == '[object Object]') {
                // post
                let proxyparam = "proxyparam=" + base64.encode(JSON.stringify({
                    url,
                    data
                }));
                //通过中转页面，先传递参数到中转页面，再从中转页面post到目标地址，因为app中限制了非http和https协议开头的都尝试打开APP
                window.open(serverUrl + "/Proxy/GetToPostWithEncode?" + proxyparam, "_system");
            } else {
                // get
                window.open(url, "_system");
            }
        } else {
            // let pageContentUrl = '';
            // if (data && Object.prototype.toString.call(data) == '[object Object]') {
            //     //post form data，HB and some deposit
            //     let pageContent = '';
            //     for (let key in data) {
            //         pageContent += `<input type="hidden" name="${key}" value="${data[key]}">`
            //     }
            //     pageContentUrl = 'data:text/html;base64,' + base64.encode(`
            //     <html>
            //     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui, viewport-fit=cover">
            //     <head></head><body><p>Loading...</p><form id="loginForm" action="${url}" method="post">
            //         ${pageContent}
            //     </form> <script type="text/javascript">document.getElementById("loginForm").submit();</script></body></html>`);
            // } else {
            //     // get， client service and most game
            //     pageContentUrl = url;
            // }
            // let opener = cordova.ThemeableBrowser.open(pageContentUrl, '_blank,' + orientation, {

            let opener = cordova.ThemeableBrowser.open(pageContentUrl, '_blank', {
                statusbar: {
                    color: '#EBCE9C'
                },
                title: {
                    color: '#000000',
                    showPageTitle: true,
                    staticText: gameName
                },
                closeButton: {
                    wwwImage: 'resource/images/wap/back.png',
                    wwwImagePressed: 'resource/images/wap/back.png',
                    // image: 'ic_action_previous_item',
                    // imagePressed: 'ic_action_previous_item',
                    wwwImageDensity: 2,
                    align: 'left'
                },
                // fullscreen:true,
                toolbar: {
                    height: 30,
                    color: '#EBCE9C'
                }
            });
        }

    } else {
        if (target == "_blank" || target == "_system" || target == "_default") {
            window.open(url, "_blank");
        } else {
            window.location.href = url;
        }
    }
}

export const lazyLoad = (router) => {

}
