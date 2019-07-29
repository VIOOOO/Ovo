<template>
    <f7-page class="login">
        <div class='Commonnavbar'>
            <ul class="searchBox">
                <li class="leftSide" @click="jumpLinks('/Member/MyCenter')">
                    <i class="icon iconfont icon-X"></i>
                </li>
            </ul>
        </div>
        <div class="section">
            <div class="a_block">
                {{passwordLogin?"手机登录":"密码登录"}}
            </div>
            <div class="b_block">
                <div class='applyTable'>
                    <table>
                        <tr>
                            <td class="second-col PhoneNumb">
                                <input v-inputprevent type="text" ref="PhoneNumb" autocapitalize="off" autocomplete="off" autocorrect="off" class="input-focused" name="loginname" placeholder="请输入11位手机号" v-model="PhoneNumb">
                                <i class="icon iconfont icon-guanbi1" v-if="PhoneNumb" @click="PhoneNumb=''"></i>
                            </td>
                        </tr>
                        <tr v-if="!passwordLogin">
                            <td class="second-col password">
                                <input v-inputprevent type="password" v-if="!showPassWord" name="password" maxlength="16" v-model="password" placeholder="请输入6-15位数字与英文结合">
                                <input v-inputprevent type="text" v-if="showPassWord" name="password" maxlength="16" v-model="password" placeholder="请输入6-15位数字与英文结合">
                                <div class="getCode add" @click="showPassWord=!showPassWord">
                                    <img v-show="!showPassWord" :src="icon_checkHide" alt="">
                                    <img v-show="showPassWord" :src="icon_checkOpen" alt="">
                                    <!-- {{showPassWord?'隐藏密码':'显示密码'}} -->
                                </div>
                            </td>
                        </tr>
                        <tr v-else>
                            <td class="second-col password">
                                <input v-inputprevent type="text" name="password" maxlength="16" v-model="verifiyCode" placeholder="请输入验证码">
                                <em class="getCode" @click="getCode">{{btntxt}}</em>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="agreeContract">
                    <i :class="['icon','iconfont',{'icon-duihao11':agreeContract},{'icon-yuanquan':!agreeContract}]" @click="agreeContract=!agreeContract"></i> 登录即表示您同意<span @click="jumpLinks('/CN/PrivacyPolicylogin')">我们的协议</span>
                </div>
                <div class="inputWrap">
                    <input :class="['col button button-fill submit',{'showsubmit':showLog}]" type="button" :value="ClickMark?'登 录':'登录中...'" @click="loginIn">
                </div>
                <div class="passwordLogin">
                    <a href="javascript:;" v-if="passwordLogin" @click="passwordLogin=!passwordLogin">密码登录</a>
                    <a href="javascript:;" v-else @click="passwordLogin=!passwordLogin">手机登录</a>
                </div>
                <div class="alertMSG" v-if="passwordLogin">
                    <p>未注册用户登录后自动注册</p>
                </div>
            </div>
        </div>
        <!-- 全屏loader -->
        <!-- <loaderPage :bgBlack="true"></loaderPage> -->
    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, Getip, contactNoPattern, passwordPattern, realNamePattern } from "@/config/env";
import Commonnavbar from "@/components/wap/common/Commonnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from 'js-cookie'
let cache = new wsCache();
export default {
    data() {
        return {
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            loginIcon01: buildImg(require("@/assets/wap/images/Login/loginIcon01.png")),
            loginIcon02: buildImg(require("@/assets/wap/images/Login/loginIcon02.png")),
            icon_checkHide: buildImg(require("@/assets/wap/images/Login/icon_checkHide.png")),
            icon_checkOpen: buildImg(require("@/assets/wap/images/Login/icon_checkOpen.png")),
            prefix,
            PhoneNumb: "",  // 手机号
            password: "",   // 密码
            remmber: ["1"],
            ClickMark: true,
            agreeContract: true,    // 同意协议
            passwordLogin: true,    // 手机登录
            showPassWord: false,    // 显示密码
            Phone: "",
            verifiyCode: "",        // 验证码
            time: 60,
            btntxt: "获取验证码",
            disabledVerify: true,
            disableRedButton: true,
            warn: "",
            verifiyCode: "",
            verifyTimer: null,
            onlyOneClick: true
        }
    },
    created() {
        const that = this;
        that.$nextTick(() => {
            document.onkeydown = function (ev) {
                // console.log(ev.keyCode)
                if (that.loginname && that.password && ev.keyCode == 13) {
                    that.loginIn()
                }
            }
            const data = cache.get("memberlogin");
            if (data && Object.prototype.toString.call(data) == "[object Object]") {
                this.loginname = data.loginname || "";
                this.password = data.password || "";
            }
        })

    },
    computed: {
        ...mapGetters(["UserInfo"]),
        filterPhon: function () {
            return contactNoPattern.test(this.PhoneNumb.replace(/\s/g, ""));
        },
        showLog() {
            if (this.passwordLogin) {
                if (this.PhoneNumb.replace(/\s/g, "") && this.verifiyCode.replace(/\s/g, "")) {
                    return true
                } else {
                    return false
                }
            } else {
                if (this.PhoneNumb.replace(/\s/g, "") && this.password.replace(/\s/g, "")) {
                    return true
                } else {
                    return false
                }
            }
        }
    },
    components: { Commonnavbar },
    methods: {
        jumpLinks(url) {
            window.jumpLink(url, "_router");
        },
        async getCode() {
            const that = this;
            if (that.filterPhon) {

                if (that.disabledVerify) {
                    if (that.time > 0) {
                        that.verifyTimer = setInterval(function () {
                            that.time--;
                            if (that.time <= 0) {
                                clearInterval(that.verifyTimer);
                                that.time = 60;
                                that.btntxt = "获取验证码";
                                that.disabledVerify = true;
                                that.disableRedButton = true;
                            } else {
                                that.btntxt = that.time + "s后重新获取";
                            }
                        }, 1000);
                        that.disabledVerify = false
                    }
                } else {
                    that.$store.commit(TYPES.ALERT_TIP, {
                        show: true,
                        title: "手机验证",
                        content: that.btntxt
                    });
                    return
                }
                if (that.disableRedButton) {
                    let ResualtData = await that.$store.dispatch('SendMobileValidateCode', {
                        "Ip": Getip.address(),
                        "Phone": that.PhoneNumb,
                        "PhoneValidateCode": "3",
                        "Type": 1,
                        "Id": "0"
                    })
                    if (ResualtData.StatusCode == "0") {
                        that.disableRedButton = false
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content: "获取验证码成功!"
                        });
                        return
                    } else {
                        that.disableRedButton = false
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content: ResualtData.Message
                        });
                        return
                    }
                }
            } else {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "手机验证",
                    content: "请输入正确的手机号"
                });
                return
            }



        },

        async loginIn() {

            const that = this;
            if (that.passwordLogin && (!that.PhoneNumb || !that.verifiyCode)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入手机号和验证码`
                });
                return;

            }
            if (!that.passwordLogin && (!that.PhoneNumb || !that.password)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入手机号和密码`
                });
                return;

            }
            if (!contactNoPattern.test(this.PhoneNumb)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入11位有效手机号`
                });
                return
            }
            if (!that.passwordLogin && !passwordPattern.test(that.password)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入6-15位数字与英文结合密码`
                });
                return
            }
            let Reg = /^\d{4}$/g
            if (that.passwordLogin && !Reg.test(that.verifiyCode)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入4位数字验证码`
                });
                return
            }
            if (!that.agreeContract) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请同意我们的协议`
                });
                return
            }
            if (this.onlyOneClick) {
                if (this.passwordLogin) {
                    that.onlyOneClick = false;
                    that.$store.dispatch("LoaderPage", true);
                    try {
                        clearUser()
                        this.$store.commit('PhoneNum', this.PhoneNumb);
                        this.$store.commit('verifiyCode', that.verifiyCode);
                        let ResualtData = await that.$store.dispatch("LoginWithCode", {
                            input: that.PhoneNumb,
                            code: that.verifiyCode,
                        })
                        that.$store.dispatch("LoaderPage", false)
                        if (ResualtData.StatusCode == "0") {
                            that.onlyOneClick = true;
                            const UserInfo = cookie.getJSON('UserInfo');
                            const negix_SessionId = cookie.getJSON('negix_SessionId');
                            if (UserInfo) {
                                cookie.remove('UserInfo');
                            }
                            cookie.set('UserInfo', ResualtData.Data, {
                                path: '/'
                            });
                            if (negix_SessionId) {
                                cookie.remove('negix_SessionId');
                            }
                            cookie.set('negix_SessionId', ResualtData.Data.Token, {
                                path: '/'
                            });
                            that.$store.commit('UserInfo', ResualtData.Data);
                            window.jumpLink('/Member/MyCenter', '_router');
                        }
                        else if (ResualtData.Message == "帐号不存在") {
                            that.onlyOneClick = true;
                            window.jumpLink('/CN/UserInfor', '_router');
                            return
                        } else {
                            that.onlyOneClick = true;
                            if (ResualtData.Message == "未登录") {
                                clearUser();
                                window.jumpLink('/Member/Home', '_router');
                            }
                            that.$store.commit(TYPES.ALERT_TIP, {
                                show: true,
                                content: ResualtData.Message
                            });
                            return
                        }

                    } catch (e) {
                        that.$store.dispatch("LoaderPage", false)
                    }
                } else {
                    that.$store.dispatch("LoaderPage", true);
                    try {
                        clearUser()
                        let ResualtData = await that.$store.dispatch("LoginWithPassword", {
                            input: that.PhoneNumb,
                            password: that.password,
                        })
                        that.$store.dispatch("LoaderPage", false)
                        if (ResualtData.StatusCode == "0") {
                            that.onlyOneClick = true;
                            const UserInfo = cookie.getJSON('UserInfo');
                            const negix_SessionId = cookie.getJSON('negix_SessionId');
                            if (UserInfo) {
                                cookie.remove('UserInfo');
                            }
                            cookie.set('UserInfo', ResualtData.Data, {
                                path: '/'
                            });
                            if (negix_SessionId) {
                                cookie.remove('negix_SessionId');
                            }
                            cookie.set('negix_SessionId', ResualtData.Data.Token, {
                                path: '/'
                            });
                            that.$store.commit('UserInfo', ResualtData.Data);
                            window.jumpLink('/Member/MyCenter', '_router');
                        }
                        else if (ResualtData.Message == "帐号不存在") {
                            that.onlyOneClick = true;
                            that.$store.commit(TYPES.ALERT_TIP, {
                                show: true,
                                content: "帐号不存在"
                            });
                            return
                        } else {
                            that.onlyOneClick = true;
                            if (ResualtData.Message == "未登录") {
                                clearUser();
                                //   window.jumpLink('/Member/Home', '_router');
                            }
                            that.$store.commit(TYPES.ALERT_TIP, {
                                show: true,
                                content: ResualtData.Message
                            });
                            return
                        }

                    }
                    catch (e) {
                        that.$store.dispatch("LoaderPage", false)
                    }
                }

            } else {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "登录请求中"
                });
                return
            }
        }
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.login {
    // background: #f5f5f5;
    .section {
        padding: 0.25rem 0.65rem 20% 0.65rem;
        position: relative;
        color: $white;
        .a_block {
            text-align: left;
            padding: 1rem 0.2rem 2rem;
            color: #000000;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .b_block {
            .applyTable {
                table {
                    width: 100%;
                    margin: 0 auto;
                }
                .second-col {
                    position: relative;
                    padding-bottom: 0.4rem;
                    color: $font_color;
                    // border-bottom: 1px solid #dcdcdc;
                    span {
                        position: absolute;
                        top: 0;
                        left: 0;
                        display: inline-block;
                        font-size: 0.8rem;
                        height: 1.7rem;
                        line-height: 1.7rem;
                        padding: 0 0.4rem;

                        > img {
                            height: 0.88rem;
                            vertical-align: middle;
                        }
                    }
                    span::after {
                        position: absolute;
                        right: 0;
                        top: 0.4rem;
                        content: "";
                        height: 60%;
                        width: 1px;
                        background: #000;
                    }
                    input {
                        font-size: 0.7rem;
                        background-color: $white;
                        width: 100%;
                        height: 2.2rem;
                        line-height: 2.2rem;
                        padding: 0 0.5rem;
                        border-radius: 10px;
                        box-shadow: 0 2px 2px #b1b1b1;
                    }
                    .iconfont {
                        font-size: 1.1rem;
                        position: absolute;
                        top: 0.5rem;
                        right: 0.4rem;
                        line-height: 1.2rem;
                        &.icon-guanbi1 {
                            opacity: 0.6;
                            color: #464646;
                            font-size: 0.9rem;
                        }
                    }
                    .getCode {
                        position: absolute;
                        top: 0;
                        right: 0.4rem;
                        color: #ed1721;
                        font-style: normal;
                        line-height: 2.2rem;
                        &.add {
                            // color: #c1c1c1;
                            width: 2rem;
                             text-align: center;
                            > img {
                                width: 1.1rem;
                            }
                            // &::before {
                            //     content: "";
                            //     height: 0.5rem;
                            //     width: 1px;
                            //     background: #c1c1c1;
                            //     position: absolute;
                            //     left: -0.45rem;
                            //     top: 0.15rem;
                            // }
                        }
                    }
                }
            }
        }
        .agreeContract {
            color: #888;
            height: 1.5rem;
            text-align: center;
            margin: 1.5rem 0 0.2rem;
            span {
                color: #fe6066;
            }
            .icon-duihao11 {
                color: #fe6066;
            }
            .icon-yuanquan {
                color: #372d21;
            }
        }
        .inputWrap {
            width: 100%;
            margin: 0 auto;
            input {
                font-size: $font_rem_big;
                // font-weight: bold;
                border: none;
                border-radius: 10px;
                height: 2rem;
                // box-shadow: 0 0px 2px rgba($color: #ffc21f, $alpha: 1);
            }
            .submit {
                background: #ed1721;
                color: #fff;
                 opacity: 0.4;
            }
            .showsubmit{
                opacity: 1;
            }
        }
        .passwordLogin {
            margin-top: 1rem;
            padding: 0.5rem;
            text-align: center;
            a {
                color: #1576d4;
            }
        }
        .alertMSG {
            color: #808080;
            text-align: center;
            margin-top: 1.5rem;
        }
    }
}
// 搜索栏

.searchBox {
    // background: #ffffff;
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: flex-end;
    // border-bottom: 1px solid #fac307;
    //   box-shadow: 0  0px  2px rgba($color: #ffe29c, $alpha: 0.35);

    li.leftSide {
        // flex: 1;
        // .icon-back-arrow {
        //     color: #ffc001;
        //     font-size: 1.35rem;
        // }
        padding-right: 0.4rem;
        .icon-X {
            font-size: 1.35rem;
        }
    }
    li.rightSide {
        flex: 20;
        position: relative;
        color: #030303;
        text-align: center;
        text-indent: -15%;
        font-size: 0.7rem;
        font-weight: bold;
    }
}
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>


