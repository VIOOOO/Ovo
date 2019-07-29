/**
 * 配置编译环境和线上环境之间的切换
 * 
 * baseUrl: 域名地址
 * routerMode: 路由模式
 * imgBaseUrl: 图片所在域名地址
 * systemOs: 操作系统
 * prefix ：前缀 d
 * openCache : 开启缓存
 * clientContact: 客服地址
 * serverUrl:服务器地址
 * assetUrl : 发布地址
//  * clientLogin : 大獎登錄器
 * copyright : 版权
 * affiliate : 加盟合作地址
 * siteTheme:网站主题函数
 * getQueryString:获取url参数
 * addEvent : 兼容性IE、chrome添加事件方法
 * makeQRCode : 生成二维码
 * isApp : 是否是APP
 * isWap : 是否是WAP
 * isPc  : 是否是PC
 * isHand : 是否移动设备，包括 app 、 h5网页 、 ipad
 * getFormData : 获取表单对象
 * formatMoney: 格式化金额
 * isiOS : 是否ios
 * isAndroid ：是否Android
 * androidUrl: android App 下载地址
 * iosUrl : ios app 下载地址
 * encodeAppUrl : 中转站地址
 * 
 */
import './polyfill'
import axios from 'axios'
import theme from '../theme/theme'
// import imgServerConfig from '@/data/config'
import xdhelper from 'xdhelper'
import QRCode from "qrcode";
import base64 from './base64';
import jsCookie from 'js-cookie';
import Getip from 'ip';



/**
 * 从config/config.js 中导出 assetsPublicPath 配置
 */
let assetUrl = process.env.ASSETS_PATH;
let baseUrl = '';
let routerMode = 'history';
let imgServerArray = [];
// const imgSiteFolder = "/";
const imgSiteFolder = assetUrl;
let systemOs = 'pc';
let siteTheme = {};
let isiOS = xdhelper.isiOS();
let isAndroid = xdhelper.isAndroid();
/**
 * 路由显示模式
 */
// let routerOs = 'pc';
// console.log(process.env)
let prefix = 'd';
let openCache = true;
const npm_cmd = process.env.MODE_NPM_CMD;
let serverUrl = location.origin || '';
let isApp = true;
let isWap = true;
let isPc = true;
let isHand = false;
//android url需要填写服务器地址
// if (process.env.MODE_NPM_CMD.includes('-android') || process.env.NODE_ENV == 'development') {
//     serverUrl = `http://lhj8.ws`;
// }
if (!npm_cmd.includes('-android')) {
    isApp = false;
}
if (!npm_cmd.includes('-wap')) {
    isWap = false;
}
if (!npm_cmd.includes('-pc')) {
    isPc = false;
}
if (isApp || isWap) {
    isHand = true;
}

if (isApp) {
    serverUrl = 'http://192.100.100.1'; // 正式环境
    if (npm_cmd.includes('-test')) {
        serverUrl = `http://test123.com`; // 测试环境
    }
}

// let isHttp = 'http:' == document.location.protocol ? 'http:' : 'https:';
// serverUrl=isHttp+'//test123.com';


// const getQueryString = (name)=>{
//     var reg = new RegExp("(^|&)" + name.toUpperCase() + "=([^&]*)(&|$)");
//     var r = window.location.search.toUpperCase().substr(1).match(reg);
//     if (r != null) return unescape(r[2]); return null;
// }

const queryParams = xdhelper.getQueryParam();
const getQueryString = (name = '') => {
    // console.log(queryParams)
    return queryParams[name.toLowerCase()];
}


// pc 或者 wap
if (xdhelper.isPhone() || isApp) {
    systemOs = "wap";
}
// url中有patm参数，则显示pc版，这是手机跳转网页版固定的
if (getQueryString('patm')) {
    systemOs = "pc";
}
// url中有os参数，则显示wap版，这是手机固定的
if (getQueryString('os')) {
    systemOs = "wap";
}

/**
 * 网站主题
 */
let hostname = location.hostname.replace(/^www./i, '').toLowerCase();
let maintheme = '',
    siteThemeKey = '';
for (let t in theme) {
    let sites = theme[t];
    /**
     * 全局主题
     */
    if (Object.prototype.toString.call(sites) == '[object String]') {
        if (sites == "*") {
            maintheme = t;
        }
        if (sites == "*" && siteThemeKey == null) {
            siteThemeKey = maintheme;
        }
        if (sites != "*" && sites == hostname) {
            siteThemeKey = t;
        }
    } else if (Object.prototype.toString.call(sites) == '[object Array]') {
        for (let s of sites) {
            if (s == hostname) {
                siteThemeKey = t;
            }
        }
    }
}
if (!siteThemeKey) {
    siteThemeKey = maintheme;
}

let mainSiteThemejson = {}
for (let t in theme) {
    if (t == siteThemeKey || t == '*') {
        /**
         * 打包所有主题中图片
         */
        let obj = require('../theme/' + t + '/pc.json')
        for (let s in obj) {
            if (obj[s].type == 'resource') {
                /**
                 * 自动判断是否cdn服务器
                 */
                siteTheme[s] = buildImg('' + (npm_cmd.includes('build-') ? imgSiteFolder : '/') + obj[s].content.replace('/', ''));
            } else {
                siteTheme[s] = obj[s].content;
            }
        }
    }
}
/**
 * 子站覆盖主站
 */
siteTheme = Object.assign({}, mainSiteThemejson, siteTheme)

/**新客服 */
const clientContact = `https://chatClient/chatbox.jsp?codeType=custom&enterurl=${isApp ? (isAndroid ? 'android' : 'ios') : location.hostname}`


/** 正则验证 */
const copyright = `${siteTheme.alias}官方网站 Copyright © 2010-2018 ptpt8 Online Game. All rights reserved.`
const affiliate = "https://join.com/"; // 加盟地址
const realNamePattern = /^[\u4E00-\u9FA5\·]+$/;
const numericPattern = /^\d+$/;
const decimalPattern = /^\d+(\.\d+)?$/
const onlyLetters = /^[a-zA-Z]+$/;
const numbersAndLetters = /^[A-Za-z0-9]+$/;
const contactNoPattern = /^0*[1][3,4,5,6,7,8,9]\d{9}$/
const emailPattern = /^(([^<>()\[\]\\.,:\s@"]+(\.[^<>()\[\]\\.,:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
const qqPattern = /^[1-9]\d{4,11}$/
const passwordPattern = /^[0-9a-zA-Z]{6,16}$/;
const wechatPattern = /^[a-zA-Z0-9]([-_a-zA-Z0-9]{5,19})+$/;
const bankCardNumPattern = /^([1-9]{1})([\S]{5,23})$/
if (process.env.NODE_ENV == 'development') {
    baseUrl = ''
} else if (process.env.NODE_ENV == 'production') {
    baseUrl = '';
}

/**
 * 是否从图片服务器加载图片,dev-serimg和build-serimg两种打包方式使用图片服务，否则使用本地图片
 * 配置见package.json 和 /config/prod.env.js 的MODE_NPM_CMD变量
 * @param {*} path 
 */
/**
 * 同步取得图片服务器地址
 */
//if (npm_cmd.includes('-serimg')) {
//   axios.get(assetUrl + "static/config.json?v=" + (new Date()).getTime()).then(response => {
//     const config = response.data;
//     imgServerArray = config.imgServer;
//   });
//imgServerArray = imgServerConfig.imgServer;
//}

function buildImg(path) {
    const ran = Math.round(Math.random() * (imgServerArray.length - 1));
    let imgBaseUrl = "";
    /**
     * data:image base64 的不加前缀，空cdn域名不加前缀
     */
    if (ran > -1 && ran < imgServerArray.length && imgServerArray[ran].replace(/ /g, '')) {
        if (imgServerArray[ran].startsWith('http')) {
            imgBaseUrl = imgServerArray[ran];
        } else {
            imgBaseUrl = "//" + imgServerArray[ran];
        }
    }
    // console.log(npm_cmd,path)
    if (npm_cmd.includes('build-') && !path.startsWith('data:image')) {
        return imgBaseUrl + path
    } else if (npm_cmd.includes('dev-') && !path.startsWith('data:image')) {
        return imgBaseUrl + imgSiteFolder + path.replace('/', '')
    } else if (isApp && !path.startsWith('data:image')) {
        // return 'android_asset/www/' + path
        return path;
    } else {
        return path;
    }
}






const addEvent = (function () {
    if (document.addEventListener) {
        return function (el, type, fn) {
            if (el.length) {
                for (var i = 0; i < el.length; i++) {
                    addEvent(el[i], type, fn);
                }
            } else {
                el.addEventListener(type, fn, false);
            }
        };
    } else {
        return function (el, type, fn) {
            if (el.length) {
                for (var i = 0; i < el.length; i++) {
                    addEvent(el[i], type, fn);
                }
            } else {
                el.attachEvent('on' + type, function () {
                    return fn.call(el, window.event);
                });
            }
        };
    }
})();


function makeQRCode(link = "") {
    // margin :二维码安静区域宽度，值越小白边越小，默认4
    let ret = ''
    let segs = {
        margin: "1",
        errorCorrectionLevel: "H"
    }

    if (link) {
        QRCode.toDataURL(link, segs, function (err, url) {
            ret = url;
        });
    }
    return ret;
}

// cookie 緩存
const cookie = jsCookie.withConverter({
    read: function (value, name) {
        return value;
    },
    write: function (value, name) {
        return value;
    }
});

// 清除代理缓存信息调取新用户
const updateUserInfo = async () => {
    cookie.remove('UserInfo');
    $local.vm.$store.commit("UserInfo", null)
    await $local.vm.$store.dispatch('UserInfo');
}
// 清除緩存
const clearUser = () => {
    cookie.remove('negix_SessionId');
    cookie.remove('UserInfo');
    $local.vm.$store.commit("UserInfo", null)
    // window.localStorage.clear();
}
const restoreLogin = () => {
    /**
     * 30 分钟没请求接口，就自动退出到首页
     */
    let timer = null;
    if (timer) {
        timer = clearTimeout(timer)
    }
    timer = setTimeout(function () {
        //  clearUser()
        window.location.reload()
    }, 20 * 60 * 1000);
}
const json2KeyValue = json => {
    let arr = [];
    for (let key in json) {
        arr.push({
            Key: key.toUpperCase(),
            Value: encodeURIComponent(json[key])
        })
    }
    return arr;
}

const keyValue2Json = arr => {
    let json = {};
    if (arr instanceof Array)
        arr.forEach(a => {
            json[a.Key.toLowerCase()] = decodeURIComponent(a.Value);
        })
    if (!arr || arr.length == 0) {
        return null;
    }
    return json;
}

const getFormData = form => {
    let elementsObj = form.elements;
    let object = elementsObj.length ? {} : null;
    for (let i = 0; i < elementsObj.length; i += 1) {
        let obj = elementsObj[i];
        if (obj.name) {
            object[obj.name] = obj.value;
        }
    }
    return object;
}

const formatMoney = (number, places, symbol, thousand, decimal) => {
    number = number || 0;
    places = !isNaN((places = Math.abs(places))) ? places : 2;
    symbol = symbol !== undefined ? symbol : "$";
    thousand = thousand || ",";
    decimal = decimal || ".";
    var negative = number < 0 ? "-" : "",
        i = parseInt((number = Math.abs(+number || 0).toFixed(places)), 10) + "",
        j = (j = i.length) > 3 ? j % 3 : 0;
    return (
        symbol +
        negative +
        (j ? i.substr(0, j) + thousand : "") +
        i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) +
        (places ?
            decimal +
            Math.abs(number - i)
                .toFixed(places)
                .slice(2) :
            "")
    );
}


let androidUrl = "http://testandroid/test.apk";
let iosUrl = "https://testios/";


const encodeAppUrl = (url) => {
    return 'https://test555.asia?id=' + base64.encode(url);
}


const jumpLinUrl = (url, target, data, orientation = "LANDSCAPE", gameName) => {
    // target : _blank 表示用app打开
    // target : _system 表示用app内浏览器打开，url不可编辑
    // target : _default 表示用app内浏览器打开，url可编辑，如UC浏览器、谷歌浏览器、Safari浏览器
    // target : _router 表示通过路由跳转
    // target : _jumpOut 表示通过路由跳转
    if (target == '_Innerjump' && isApp) {
        let opener = cordova.InAppBrowser.open(url, '_blank', 'location=yes');

    }
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
            let pageContentUrl = '';
            if (data && Object.prototype.toString.call(data) == '[object Object]') {
                //post form data，HB and some deposit
                let pageContent = '';
                for (let key in data) {
                    pageContent += `<input type="hidden" name="${key}" value="${data[key]}">`
                }
                pageContentUrl = 'data:text/html;base64,' + base64.encode(`
                <html>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui, viewport-fit=cover">
                <head></head><body><p>Loading...</p><form id="loginForm" action="${url}" method="post">
                    ${pageContent}
                </form> <script type="text/javascript">document.getElementById("loginForm").submit();</script></body></html>`);
            } else {
                // get， client service and most game
                pageContentUrl = url;
            }
            // let opener = cordova.ThemeableBrowser.open(pageContentUrl, '_blank,' + orientation, {
            //     statusbar: {
            //         color: '#EBCE9C'
            //     },
            //     title: {
            //         color: '#000000',
            //         showPageTitle: true,
            //         staticText: gameName
            //     },
            //     closeButton: {
            //         wwwImage: 'resource/images/wap/back.png',
            //         wwwImagePressed: 'resource/images/wap/back.png',
            //         // image: 'ic_action_previous_item',
            //         // imagePressed: 'ic_action_previous_item',
            //         wwwImageDensity: 2,
            //         align: 'left'
            //     },
            //     // fullscreen:true,
            //     toolbar: {
            //         height: 30,
            //         color: '#EBCE9C'
            //     }
            // });
        }
    } else {
        if (target == "_blank" || target == "_system" || target == "_default") {
            window.open(url, "_blank");
        } else {
            window.location.href = url;
        }
    }
}




export {
    jumpLinUrl,
    baseUrl,
    routerMode,
    imgBaseUrl,
    systemOs,
    prefix,
    openCache,
    clientContact,
    serverUrl,
    assetUrl,
    // clientLogin,
    copyright,
    affiliate,
    buildImg,
    realNamePattern,
    numericPattern,
    decimalPattern,
    numbersAndLetters,
    onlyLetters,
    contactNoPattern,
    emailPattern,
    qqPattern,
    passwordPattern,
    wechatPattern,
    bankCardNumPattern,
    //   routerOs,
    siteTheme,
    getQueryString,
    addEvent,
    makeQRCode,
    isApp,
    cookie,
    updateUserInfo,
    clearUser,
    restoreLogin,
    json2KeyValue,
    keyValue2Json,
    isHand,
    getFormData,
    formatMoney,
    isAndroid,
    isiOS,
    isPc,
    isWap,
    androidUrl,
    iosUrl,
    encodeAppUrl,
    Getip
}