<template>
    <f7-page class="login">
        <navbar title="完善个人信息" back="/CN/Login"></navbar>
        <!--刚注册时候进入的完善个人信息页面 -->
        <section class="userInfoBlock">
            <ul class="userInfo">
                <li>
                    <div class="left">真实姓名：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="realName" value="" maxlength="30" placeholder="请输入真实姓名(必填)">
                    </div>
                </li>
                <li>
                    <div class="left">邀请码：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="InvitationCode" value="" maxlength="30" placeholder="请输入邀请码(选填)">
                    </div>
                </li>
                <li>
                    <div class="left">微信：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="weChat" value="" placeholder="请输入您的微信号(选填)">
                    </div>
                </li>
                <li>
                    <div class="left">QQ：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="QQ" value="" maxlength="12" placeholder="请输入您的QQ(选填)">
                    </div>
                </li>
                <li>
                    <div class="left">邮箱：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="email" value="" placeholder="请输入您的邮箱(选填)">
                    </div>
                </li>

            </ul>
            <ul class="informsg">
                <li>使用好友的邀请页面注册，直接绑定好友，无需再填邀请码；</li>
                <li>首次注册登录在本页面，输入好友的邀请码，也可进行绑定，两种绑定方式系统默认以链接为主；</li>
                <li>绑定后不能解除、更改绑定。</li>
            </ul>
            <div class="inputWrap">
                <input class="col button button-fill submit" @click="RegisterUser" type="button" :value="ClickMark?'完成':'提交中...'">
            </div>

        </section>

    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, Getip, realNamePattern, emailPattern, qqPattern, wechatPattern } from "@/config/env";
import navbar from "@/components/wap/common/nosearchnavbar";
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
            prefix,
            loginname: "",
            password: "",
            remmber: ["1"],
            ClickMark: true,
            agreeContract: true,
            passwordLogin: true,
            realName: "",
            weChat: "",
            QQ: "",
            email: "",
            InvitationCode: ""

        }
    },
    created() {

    },
    computed: {
        ...mapGetters(["UserInfo", "CustomAlertTip", "PhoneNum", "deviceUuid", "verifiyCode"])
    },
    components: { navbar },
    methods: {
        jumpLink() {
            window.jumpLink('/Member/MyCenter', '_router');
        },
        async RegisterUser() {
            let that = this;
            if (!that.realName) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `真实姓名为必填项`
                });
                return;
            }
            if (!realNamePattern.test(this.realName)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入真实中文姓名!`
                });
                return;
            }
            if (this.InvitationCode && !numbersAndLetters.test(this.InvitationCode)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入格式正确的邀请码!`
                });
                return;
            }
            if (this.weChat && !wechatPattern.test(this.weCha)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "请输入正确的微信号"
                });
                return
            }
            if (this.QQ && !qqPattern.test(this.QQ)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "请输入正确的QQ账号"
                });
                return
            }
            if (this.email && !emailPattern.test(this.email)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "请输入正确的邮箱地址"
                });
                return
            }
            that.$store.dispatch("LoaderPage", true)

            let ResualtData = await this.$store.dispatch('RegisterUser', {
                "UserName": "",
                "Phone": that.PhoneNum,
                "WeChat": that.weChat,
                "QQ": that.QQ,
                "Sex": true,
                "NickName": "",
                "InvitationCode": that.InvitationCode,
                "DeviceUuid": that.deviceUuid,
                "Email": that.email,
                "RegisterIp": Getip.address(),
                "RealName": that.realName,
                "PhoneCode": that.verifiyCode,
            })
            if (ResualtData.StatusCode == "0") {

                let LoginResualtData = await that.$store.dispatch("LoginWithCode", {
                    input: that.PhoneNum,
                    code: that.verifiyCode,
                })
                if (LoginResualtData.StatusCode == "0") {

                    that.$store.dispatch("LoaderPage", false)
                    const UserInfo = cookie.getJSON('UserInfo');
                    const negix_SessionId = cookie.getJSON('negix_SessionId');
                    if (UserInfo) {
                        cookie.remove('UserInfo');
                    }
                    cookie.set('UserInfo', LoginResualtData.Data, {
                        path: '/'
                    });
                    if (negix_SessionId) {
                        cookie.remove('negix_SessionId');
                    }
                    cookie.set('negix_SessionId', LoginResualtData.Data.Token, {
                        path: '/'
                    });
                    that.$store.commit('UserInfo', LoginResualtData.Data);
                    window.jumpLink('/Member/MyCenter', '_router');
                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `恭喜您注册成功!`
                });
            } else {
                if (ResualtData.Message == "未登录") {
                    clearUser();

                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: ResualtData.Message
                });
                that.$store.dispatch("LoaderPage", false)
                return
            }


        },

    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.userInfoBlock {
    // background: #f5f5f5;
    height: 100%;
    padding: 0.6rem;
    .userInfo {
        background: #fff;
        margin-bottom: 0.6rem;
        border-radius: 8px;
        > li {
            display: flex;
            position: relative;
            padding: 0 0.65rem;
            height: 2.1rem;
            line-height: 2.1rem;
            //   &:last-child{
            //     border:none;
            //   }
            .td3 {
                position: absolute;
                right: 0.4rem;
                top: 0;
            }
            .left {
                flex: 36;
                font-size: 0.65rem;
            }
            .already {
                position: absolute;
                left: 0.65rem;
                top: 0;
            }
            .inp {
                flex: 100;
                text-align: left;
                input {
                    font-size: 0.65rem;
                    height: 2.2rem;
                    width: 100%;
                    display: block;
                    color: #333333;
                    line-height: 2.2rem;
                    &::-webkit-input-placeholder {
                        color: #bfbfbf;
                    }
                    &::-moz-placeholder {
                        /* Mozilla Firefox 19+ */
                        color: #bfbfbf;
                    }
                    &:-moz-placeholder {
                        /* Mozilla Firefox 4 to 18 */
                        color: #bfbfbf;
                    }
                    &:-ms-input-placeholder {
                        /* Internet Explorer 10-11 */
                        color: #bfbfbf;
                    }
                }
            }
        }
    }
    .inputWrap {
        width: 100%;
        margin: 1.75rem auto;
        input {
            font-size: 0.8rem;
            border: none;
            border-radius: 0.3rem;
            height: 1.9rem;
            letter-spacing: 3px;
        }
        .submit {
            background: #ed1721;
            color: #fff;
        }
    }
    .informsg {
        padding-top: 0.4rem;
        padding-left: 0.6rem;
        font-size: 0.48rem;
        list-style: decimal;
        > li {
            padding-bottom: 0.2rem;
        }
    }
}
// 搜索栏

// .searchBox {
//   background: #ffffff;
//   display: flex;
//   width: 100%;
//   align-items: center;
//   justify-content: center;
//   border-bottom: 1px solid #fac307;

//   li.leftSide {
//     flex: 1;
//     .icon-back-arrow {
//       color: #ffc001;
//       font-size: 1.35rem;
//     }
//   }
//   li.rightSide {
//     flex: 20;
//     position: relative;
//     color: #030303;
//     text-align: center;
//     text-indent: -15%;
//     font-size: 0.7rem;
//     font-weight: bold;
//   }
// }
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>


