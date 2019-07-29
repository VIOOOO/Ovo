// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
// import 'html5-history-api'
import 'es6-promise/auto'
import {
    systemOs,
    siteTheme,getQueryString
} from './config/env'
const c_systemOs = systemOs;
document.title = siteTheme.alias + '官方网站 ' + location.host;

//pc端删除meta值
if(c_systemOs == 'pc'){
    let head = document.getElementsByTagName('head')[0], nodes = head.childNodes, node, i = 0;
    while (node = nodes[i++]) {
        if(node.nodeType == 1 && node.tagName.toLowerCase() == 'meta' && node.getAttribute('name') == 'viewport'){
            node.setAttribute('content','');
        }
    }
}

import router from './router'
require('./assets/' + c_systemOs + '/css/layout.css')
require('./assets/' + c_systemOs + '/css/theme.heji.css')
import myvue from './myvue'
myvue(router);
