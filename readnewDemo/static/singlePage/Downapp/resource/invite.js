$(document).ready(
    function () {
        /**
         *获取url的参数
         *
         */
        function getrequest() {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
                }
            }
            return theRequest;
        }

        /**
         *发送请求并判断
         *
         */
        function request() {
            var inputval = $(".input-right input").val();
            // var reg  = /^(08|8)\d{8,11}$/;
            var reg = /^1[3456789]{1}\d{9}$/;
            // var reg = /^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\d{8}$/;
            var path = $(".submit").data('path');
            var verifyNum = $(".verifyNum").val();
            var phoneNum = $(".phoneNum").val();

            if (reg.test(inputval) && verifyNum.replace(/ /g, "") != "") {
                $(".icon-warn").hide();
                var args = getrequest();
                // if (JSON.stringify(args) == "{}" || (args && args.inviteCode.replace(/ /g, "") == "")) {
                //     toastPop("邀请链接已经失效")
                //     $(".icon-warn").show();
                //     return
                // }
                $(".loadingBlock").show();
                $.getJSON(path + "?inviteCode=" + args.inviteCode + "&phone=" + phoneNum + "&phoneCode=" + verifyNum, function (result) {
                    // console.log(result)
                    $(".loadingBlock").hide();
                    if (result.StatusCode == "0") {
                        $(".success1").removeClass("success");
                    } else {
                        toastPop(result.Message)
                        $(".icon-warn").show();
                    }
                })
            } else {
                // $(".warn1").removeClass("warn");
                toastPop("请输入正确手机号码和验证码")
                $(".icon-warn").show();
            }
        }

        /**
         *隐藏错误提示框
         *
         */
        function warnhide() {
            //$(".warn1").addClass("warn");
            //$(".input-right input").val("请输入您的手机号码");
            toastPop("请输入您的手机号码")
        }

        /**
         *隐藏成功提示框
         *
         */
        function successhide() {
            // $(".success1").addClass("success");
            var ua = navigator.userAgent.toLowerCase();
            // if (isIosOrAndroid() == "ios") {
            //     window.location.href = ""
            // } else {
                window.location.href = "https://www.6040vip.com/jubaoandroid/jubaoshare.apk"
            // }

            // if(ua.match(/MicroMessenger/i)=="micromessenger") {
            //     window.location.href='https://www.idj8866.com/CN/Mobile';
            // } else {
            //   if (isIosOrAndroid() == 'android') {
            //     // var s = getparam('s');
            //     window.location.href='https://www.idj8866.com/CN/Mobile'+s+'.apk';
            //   }
            // }
        }

        //为提交按钮绑定点击事件
        $(".submit").click(request);
        //为警告框按钮绑定点击事件
        $(".warn-submit").click(warnhide);
        //为成功提示框绑点点击事件
        $(".popup-submit").click(successhide);
        // 为获取二维码绑定事件
        $(".getCode").click(getCode)
        // 直接下载APP
        $(".downBlock .c-invite-share").click(successhide);
    })



// 判断系统是 ios or android
function isIosOrAndroid() {
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if (isAndroid) {
        return 'android'
    } else if (isiOS) {
        return 'ios'
    }
}

// viewport 动态字号

! function (win, lib) {
    var timer,
        doc = win.document,
        docElem = doc.documentElement,

        vpMeta = doc.querySelector('meta[name="viewport"]'),
        flexMeta = doc.querySelector('meta[name="flexible"]'),

        dpr = 0,
        scale = 0,

        flexible = lib.flexible || (lib.flexible = {})

    // 设置了 viewport meta
    if (vpMeta) {

        // console.warn("将根据已有的meta标签来设置缩放比例")
        var initial = vpMeta.getAttribute("content").match(/initial\-scale=([\d\.]+)/)

        if (initial) {
            scale = parseFloat(initial[1]) // 已设置的 initialScale
            dpr = parseInt(1 / scale) // 设备像素比 devicePixelRatio
        }

    }
    // 设置了 flexible Meta
    else if (flexMeta) {
        var flexMetaContent = flexMeta.getAttribute("content")
        if (flexMetaContent) {

            var initial = flexMetaContent.match(/initial\-dpr=([\d\.]+)/),
                maximum = flexMetaContent.match(/maximum\-dpr=([\d\.]+)/)

            if (initial) {
                dpr = parseFloat(initial[1])
                scale = parseFloat((1 / dpr).toFixed(2))
            }

            if (maximum) {
                dpr = parseFloat(maximum[1])
                scale = parseFloat((1 / dpr).toFixed(2))
            }
        }
    }

    // viewport 或 flexible
    // meta 均未设置
    if (!dpr && !scale) {
        var u = (win.navigator.appVersion.match(/android/gi), win.navigator.appVersion.match(/iphone/gi)),
            _dpr = win.devicePixelRatio
        dpr = u ? ((_dpr >= 3 && (!dpr || dpr >= 3)) ?
            3 :
            (_dpr >= 2 && (!dpr || dpr >= 2)) ?
                2 :
                1
        ) :
            1

        scale = 1 / dpr
    }

    docElem.setAttribute("data-dpr", dpr)

    // 插入 viewport meta
    if (!vpMeta) {
        vpMeta = doc.createElement("meta")

        vpMeta.setAttribute("name", "viewport")
        vpMeta.setAttribute("content",
            "initial-scale=" + scale + ", maximum-scale=" + scale + ", minimum-scale=" + scale + ", user-scalable=no")

        if (docElem.firstElementChild) {
            docElem.firstElementChild.appendChild(vpMeta)
        } else {
            var div = doc.createElement("div")
            div.appendChild(vpMeta)
            doc.write(div.innerHTML)
        }
    }

    function setFontSize() {
        var winWidth = docElem.getBoundingClientRect().width

        if (winWidth / dpr > 540) {
            (winWidth = 540 * dpr)
        }

        // 根节点 fontSize 根据宽度决定
        var baseSize = winWidth / 10

        docElem.style.fontSize = baseSize + "px"
        flexible.rem = win.rem = baseSize
    }

    // 调整窗口时重置
    win.addEventListener("resize", function () {
        clearTimeout(timer)
        timer = setTimeout(setFontSize, 300)
    }, false)

    // orientationchange 时也需要重算
    win.addEventListener("orientationchange", function () {
        clearTimeout(timer)
        timer = setTimeout(setFontSize, 300)
    }, false)


    // pageshow
    // keyword: 倒退 缓存相关
    win.addEventListener("pageshow", function (e) {
        if (e.persisted) {
            clearTimeout(timer)
            timer = setTimeout(setFontSize, 300)
        }
    }, false)

    // 设置基准字体
    if ("complete" === doc.readyState) {
        doc.body.style.fontSize = 12 * dpr + "px"
    } else {
        doc.addEventListener("DOMContentLoaded", function () {
            doc.body.style.fontSize = 12 * dpr + "px"
        }, false)
    }

    setFontSize()

    flexible.dpr = win.dpr = dpr

    flexible.refreshRem = setFontSize

    flexible.rem2px = function (d) {
        var c = parseFloat(d) * this.rem
        if ("string" == typeof d && d.match(/rem$/)) {
            c += "px"
        }
        return c
    }

    flexible.px2rem = function (d) {
        var c = parseFloat(d) / this.rem

        if ("string" == typeof d && d.match(/px$/)) {
            c += "rem"
        }
        return c
    }
}(window, window.lib || (window.lib = {}))

function toastPop(text) {
    $(".toast-text").fadeIn(300)
    $(".toast-text").text(text)
    setTimeout(function () {
        $(".toast-text").fadeOut(300)
    }, 2000)
};

function isIosOrAndroid() {
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if (isAndroid) {
        return 'android'
    } else if (isiOS) {
        return 'ios'
    }
}
function getparam(name) {
    var reg = new RegExp("(^|\\?|&)" + name + "=([^&]*)(\\s|&|$)", "i");
    if (reg.test(window.location.href)) {
        var str = unescape(RegExp.$2.replace(/\+/g, " "))
        if (str.indexOf("#") > -1) {
            var i = str.indexOf("#")
            return str.substring(0, i)
        } else {
            return unescape(RegExp.$2.replace(/\+/g, " "))
        }
    }
    return undefined
};
function contactNoPattern(params) {
    var reg = /^0*[1][3,4,5,6,7,8,9]\d{9}$/;
    return reg.test(params.replace(/\s/g, ""))
}
// 获取验证码
var disabledVerify = true;
var disableRedButton = true;
var btntxt = "获取验证码";
var time = 60;
var verifyTimer = null
function getCode() {
    var phoneNum = $(".phoneNum").val()
    if (contactNoPattern(phoneNum)) {
        if (disabledVerify) {
            if (time > 0) {
                verifyTimer = setInterval(function () {
                    time--;
                    if (time <= 0) {
                        clearInterval(verifyTimer);
                        time = 60;
                        btntxt = "获取验证码";
                        disabledVerify = true;
                        disableRedButton = true;
                        $(".getCode").html(btntxt)
                    } else {
                        btntxt = time + "s重新获取";
                        $(".getCode").html(btntxt)
                    }
                }, 1000);
                disabledVerify = false
            }
        } else {
            toastPop(btntxt)
            return
        }
        if (disableRedButton) {
            $.ajax({
                url: "http://192.100.100.1/api/User/SendMobileValidateCode",
                type: "POST",
                dataType: "json",
                data: { "Ip": "", "Phone": phoneNum, "PhoneValidateCode": "3", "Type": 1, "Id": "0" },
                success: function () {
                    toastPop("发送验证码成功")
                }
            })

        }
    } else {
        toastPop("请输入正确的手机号")
    }
}