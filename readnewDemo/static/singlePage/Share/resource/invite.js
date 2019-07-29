$(document).ready(
    function () {
        $(".tips-mask").click(function () {
            $(this).fadeOut()
        })
        $(".download-text").click(function () {
            $(".tips-mask").fadeIn()
        })
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
                $.getJSON(path + "?inviteCode=" + args.inviteCode + "&phone=" + phoneNum + "&phoneCode=" + verifyNum, function (result) {
                    // console.log(result)
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
            $(".success1").addClass("success");
            var ua = navigator.userAgent.toLowerCase();
            window.location.href = "http://www.6040vip.com/yinliuapp/jubaoShare.apk"
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
        $(".register .c-invite-share").click(successhide);
    })

function toastPop(text) {
    $(".toast-text").fadeIn(200)
    $(".toast-text").text(text)
    setTimeout(function () {
        $(".toast-text").fadeOut(200)
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
                        btntxt = time + "s后重新获取";
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
                url: "http://http://192.100.100.1.com/api/User/SendMobileValidateCode",
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