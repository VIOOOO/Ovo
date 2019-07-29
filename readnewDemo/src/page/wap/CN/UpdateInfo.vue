<template>
    <f7-page class="login">
        <navbar title="完善个人信息" back="/Member/MyCenter"></navbar>
        <!--已经注册过的用户修改个人信息页面 -->
        <section v-if="UserInfo" class="UpdateInfoBlock">
            <ul class="userInfo">
                <li>
                    <div class="left">真实姓名：</div>
                    <div class="inp">
                        {{UserInfo.RealName}}
                    </div>
                </li>
            </ul>
            <ul class="userInfo">
                <li>
                    <div class="left">邀请码：</div>
                    <div class="inp">
                        {{UserInfo.InvitationCode}}
                    </div>
                </li>
            </ul>
            <ul class="userInfo">
                <li>
                    <div class="left">微信：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="weChat" value="" :placeholder="UserInfo.WeChat!=null?UserInfo.WeChat:'请输入您的微信号(选填)'">
                    </div>
                    <!-- <div class="already" v-else>
                         {{UserInfo.WeChat}}
                    </div> -->
                </li>
                <li>
                    <div class="left">QQ：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="QQ" value="" maxlength="15" :placeholder="UserInfo.QQ!=null?UserInfo.QQ:'请输入您的QQ(选填)'">
                    </div>
                    <!-- <div class="already" v-else>
                         {{UserInfo.QQ}}
                    </div> -->
                </li>
                <li>
                    <div class="left">邮箱：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-model="email" value="" :placeholder="UserInfo.Email!=null?UserInfo.Email:'请输入您的邮箱(选填)'">
                    </div>
                    <!-- <div class="already" v-else>
                         {{UserInfo.Email}}
                    </div> -->
                </li>
            </ul>

            <div class="inputWrap">
                <input class="col button button-fill submit" @click="RegisterUser" type="button" :value="ClickMark?'完成':'提交中...'">
            </div>
        </section>

    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, realNamePattern, emailPattern, qqPattern, wechatPattern } from "@/config/env";
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
            if (!this.weChat && !this.QQ && !this.email) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "请输入信息"
                });
                return
            }
            // if (this.weChat && !numbersAndLetters.test(this.weCha)) {
            //     that.$store.commit(TYPES.ALERT_TIP, {
            //         show: true,
            //         content: "请输入正确的微信号"
            //     });
            //     return
            // }
            if (this.weChat && !wechatPattern.test(this.weChat)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "请输入正确的微信账号"
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
            let ResualtData = await this.$store.dispatch('UpdateUserInfo', {
                "UserName": "",
                "Phone": that.PhoneNum,
                "WeChat": that.weChat ? that.weChat : that.UserInfo.WeChat ? that.UserInfo.WeChat : "",
                "QQ": that.QQ ? that.QQ : that.UserInfo.QQ ? that.UserInfo.QQ : "",
                "Sex": true,
                "NickName": "",
                "InvitationCode": that.InvitationCode,
                "DeviceUuid": that.deviceUuid,
                "Email": that.email ? that.email : that.UserInfo.Email ? that.UserInfo.Email : "",
                "RegisterIp": "",
                "RealName": that.realName,
                "PhoneCode": that.verifiyCode,
                "Id": that.UserInfo.Id
            })
            if (ResualtData.StatusCode == "0") {
                that.$store.dispatch("LoaderPage", false)
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: "恭喜您更改成功!"
                });
                const UserInfo = cookie.getJSON('UserInfo');
                if (UserInfo) {
                    cookie.remove('UserInfo');
                }
                cookie.set('UserInfo', ResualtData.Data, {
                    path: '/'
                });
                that.$store.commit('UserInfo', ResualtData.Data);


            } else {
                that.$store.dispatch("LoaderPage", false)
                if (ResualtData.Message == "未登录") {
                    clearUser();
                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: ResualtData.Message
                });
                return
            }


        },

    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.UpdateInfoBlock {
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
}
// 搜索栏

.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>

