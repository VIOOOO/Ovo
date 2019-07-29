/**
 * format
 * @param {*} d 
 */
function keyValueArrayToObject(d) {
    var data = (Object.prototype.toString.call(d) === "[object String]") ? JSON.parse(d) : d,
        r = {};
    if (data instanceof Array) {
        for (var i = 0; i < data.length; i++) {
            var e = data[i];
            r[e.Key.toLowerCase()] = e.Value;
        }
        return r;
    } else {
        return data;
    }
}

/**
 * login
 */
function loginAjax(loginname, password, callback) {
    $.ajax({
        type: "POST",
        url: "/api/MemberLogin",
        dataType: "json",
        headers: {
            "Content-Type": "application/json"
        },
        data: JSON.stringify([{
            key: 'loginname',
            value: loginname
        },
        {
            key: 'password',
            value: password
        }
        ]),
        error: function (e) {
            $(".ajax-loading").hide();
            alert('未知错误');
        },
        success: function (data) {
            callback(data)

        }
    });
}

/**
*一键转额等
*
*/
function transferAjax(nameID, callback) {
    $.ajax({
        type: "POST",
        url: "/api/MemberTransfer2Game?providerId=" + nameID,
        dataType: "json",
        headers: {
            "Content-Type": "application/json"
        },
        data: JSON.stringify({}),
        error: function (e) {
            $(".ajax-loading").hide();
            alert('未知错误');
        },
        success: function (data) {
            callback(data);
        }
    })
}

/**
 * url 参数
 *
 */
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}


function setCookie(cname, cvalue, exdays) {
    var expires;
    if (exdays != undefined) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        expires = "expires=" + d + ";";
    } else expires = "";
    //浏览器关闭自动清空cookie
    expires = ""
    document.cookie = cname + "=" + cvalue + ";path=/;" + expires;
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
