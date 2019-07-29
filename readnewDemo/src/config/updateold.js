
import {
    isApp, isPc, isWap, isAndroid, isiOS, androidUrl
} from './env'
import TYPES from "@/store/mutation-types";
const npm_cmd = process.env.MODE_NPM_CMD;

/**
 * app 检查更新
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
            // console.log("设备号：", device.uuid)
            $local.vm.$store.commit("deviceUuid", device.uuid)
            // networkinterface.getIPAddress(function (ip) { alert(ip); });
            if(npm_cmd.includes("-init-android") || npm_cmd.includes("-test-android")){
                codePush.sync(function(status) {
                    switch (status) {
                        case SyncStatus.DOWNLOADING_PACKAGE:
                            // Show "downloading" modal
                            domMask = document.getElementById('dj_code_push_download_mask');
                            if (!domMask) {
                                domMask = document.createElement('div');
                                domMask.setAttribute("id", "dj_code_push_download_mask");
                                domMask.innerHTML = '<div id="dj_code_push_download_dialog">正在加载新版资源。。。 0%</div>';
                                document.body.appendChild(domMask);
                            }
                            domDialog = document.getElementById('dj_code_push_download_dialog');
                            break;
                        case SyncStatus.INSTALLING_UPDATE:
                            // Hide "downloading" modal
                            if (domMask) {
                                domDialog.innerHTML = "更新已完成，正在安装... ";
                            }
                            console.log("Install 更新已完成，正在安装");
                            break;
                        case SyncStatus.UPDATE_INSTALLED:
                            if (domMask) {
                                document.body.removeChild(domMask)
                            }
                            console.log("Install 安装完成");
                            break;
                    }
                }, { installMode: InstallMode.IMMEDIATE, mandatoryInstallMode: InstallMode.IMMEDIATE }, downloadProgress);
            }
            else{
                codePush.sync(function(status) {
                    switch (status) {
                        case SyncStatus.DOWNLOADING_PACKAGE:
                            break;
                        case SyncStatus.INSTALLING_UPDATE:
                            console.log("Install 更新已完成，正在安装");
                            break;
                        case SyncStatus.UPDATE_INSTALLED:
                            console.log("Install 安装完成");
                            break;
                    }
                }, { installMode: InstallMode.ON_NEXT_RESUME, mandatoryInstallMode: InstallMode.ON_NEXT_RESUME }, downloadProgress);
            }
            
            function downloadProgress(downloadProgress) {
                if (downloadProgress) {
                    // Update "downloading" modal with current download %
                    console.log("Downloading " + downloadProgress.receivedBytes + " of " + downloadProgress.totalBytes);
                    if(domDialog){
                        domDialog.innerHTML = "正在加载新版资源。。。 " + parseInt((downloadProgress.receivedBytes / downloadProgress.totalBytes) * 100) + "%";
                    }
                }
            }

            try {
                console.log("APP 版本 启动");
                //强制更新检查，检查app版本，是否需要重新下载app
                if (cordova.getAppVersion) {
                    cordova.getAppVersion.getVersionNumber(function (version) {
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
