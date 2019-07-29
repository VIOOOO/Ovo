
import {
    isApp, isPc, isWap, isAndroid, isiOS, androidUrl
} from './env'
import TYPES from "@/store/mutation-types";
// import { agentName } from "@/config/agentName";
const npm_cmd = process.env.MODE_NPM_CMD;
/**
 * app 检查更新 增量式热更新
 */
if (isApp) {
    var app = {
        // Application Constructor
        initialize: function () {
            document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
            document.addEventListener("resume", this.onDeviceReady.bind(this), false);
        },

        onDeviceReady: function () {
            var domMask, domDialog;

            let chcp = window.chcp;
            // 检测更新
            chcp.fetchUpdate((error, data) => {

                // 表示没有更新版本，或者其他错误，详情的信息参考上面的chcp error链接
                if (error) {
                    return;
                }
                // if(npm_cmd.includes("-init-android") || npm_cmd.includes("-test-android")){
                domMask = document.getElementById('dj_code_push_download_mask');
                if (!domMask) {
                    domMask = document.createElement('div');
                    domMask.setAttribute("id", "dj_code_push_download_mask");
                    domMask.innerHTML = '<div id="dj_code_push_download_dialog">正在加载新版资源。。。 0%</div>';
                    document.body.appendChild(domMask);
                }
                domDialog = document.getElementById('dj_code_push_download_dialog');
                console.log('p:'+data.progress+':p')
                if(data.progress && !isNaN(data.progress)){
                    domDialog.innerHTML = "正在加载新版资源。。。 " + parseInt(data.progress*100) + "%";
                }
            // }
                console.log("进度条", data.progress);
                //检测是否是否可以进行安装了，双重判断吧，有时候会出现有更新版本但是暂时无法安装的情况（也可以去掉这一层）
                chcp.isUpdateAvailableForInstallation((error, data) => {
                    if (error) {
                        console.log('No update was loaded => nothing to install');
                    } else {
                        // 更新中
                        chcp.installUpdate((error) => {
                            if (error) {
                                // 更新失败
                                console.log('Failed to install the update with error code: ' + error.code);
                                console.log(error.description);
                            } else {
                                // 更新成功
                                //document.body.removeChild(domMask)
                            }
                        });

                        // 对比版本号
                        console.log('Current content version: ' + data.currentVersion);
                        console.log('Ready to be installed:' + data.readyToInstallVersion);
                    }
                });
            });


            //alert(isApp, window.plugins, window.plugins.OneSignal)

            try {
                console.log("APP 版本 启动");
                //获取APP版本号
                if (cordova.getAppVersion) {
                    cordova.getAppVersion.getVersionNumber(function (version) {
                        // for (let key in agentName) {
                        //     if(version.toString()==key){
                        //         window.AgentName=agentName[key]
                        //     }                   
                        // };
                        console.log("APP版本", version)
                    });
                }
            } catch (e) {
                console.log("APP 版本 失败", e)
            }
        }
    };
    app.initialize();
}
