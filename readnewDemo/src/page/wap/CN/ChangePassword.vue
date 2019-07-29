<template>
    <f7-page class="changePasswordPages">
        <navbar title="修改密码" back="/Member/MyCenter"></navbar>
        <div class="changePasswordBlock">
            <div class="a_block">
                当前手机号为: <span v-if="UserInfo">{{UserInfo.Phone}}</span>
            </div>
            <div class="b_block">
                <div class='applyTable'>
                    <table>
                        <tr>
                            <td class="second-col">
                                <input v-inputprevent type="text" name="password" maxlength="16" autocomplete="off" v-model="verifiyCode" placeholder="请输入验证码">
                                <em class="getCode" @click="getCode">{{btntxt}}</em>
                            </td>
                        </tr>
                        <tr>
                            <td class="second-col password">
                                <input v-inputprevent type="password" autocomplete="off" v-if="!showPassword" name="password" maxlength="16" v-model="password" placeholder="请输入6-15位英文数字字符">
                               <input v-inputprevent type="text" autocomplete="off" v-else name="password" maxlength="16" v-model="password" placeholder="请输入6-15位英文数字字符">
                                 <div class="getCode add" @click="showPassword=!showPassword">
                                    <img v-show="!showPassword" :src="icon_checkHide" alt="">
                                    <img v-show="showPassword"  :src="icon_checkOpen" alt="">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="inputWrap">
                    <input class="col button button-fill submit" type="button" :value="ClickMark?'确定':'提交中...'" @click="changPassWord">
                </div>
            </div>
        </div>
        <!-- 全屏loader -->
        <!-- <loaderPage :bgBlack="true"></loaderPage> -->
    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, passwordPattern, clearUser, Getip } from "@/config/env";
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
            icon_checkHide: buildImg(require("@/assets/wap/images/Login/icon_checkHide.png")),
            icon_checkOpen: buildImg(require("@/assets/wap/images/Login/icon_checkOpen.png")),
            prefix,
            loginname: "",
            password: "",
            remmber: ["1"],
            ClickMark: true,
            agreeContract: true,
            passwordLogin: true,
            showPassword: false,    // 显示密码
            time: 60,
            btntxt: "获取验证码",
            disabledVerify: true,
            disableRedButton: true,
            warn: "",
            verifiyCode: "",
            verifyTimer: null
        }
    },
    created() {
    },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    components: { navbar },
    methods: {
        jumpLink(url) {
            window.jumpLink(url, "_router");
        },
        async getCode() {
            const that = this;
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
                that.$store.dispatch("LoaderPage", true)
                let ResualtData = await that.$store.dispatch('SendMobileValidateCode', {
                    "Ip": Getip.address(),
                    "Phone": that.UserInfo.Phone,
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
                    // window.jumpLink('/Member/Home', '_router');
                    that.$store.dispatch("LoaderPage", false)
                    return;
                } else {
                    that.disableRedButton = false
                    that.$store.commit(TYPES.ALERT_TIP, {
                        show: true,
                        title: "手机验证",
                        content: ResualtData.Message
                    });
                    that.$store.dispatch("LoaderPage", false)
                    return;
                }
            }


        },
        async changPassWord() {
            const that = this;
            if (!that.verifiyCode || !that.password) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入验证码及密码`
                });
                return;
            }
            let Reg = /^\d{4}$/g
            if (!Reg.test(that.verifiyCode)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入4位数字验证码`
                });
                return
            }
            if (!passwordPattern.test(this.password)) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入6-15位英文数字字符`
                });
                return
            };


            that.$store.dispatch("LoaderPage", true)
            try {
                let ResualtData = await that.$store.dispatch('UpdatePassword', {
                    "phone": that.UserInfo.Phone,
                    "password": that.password,
                    "phoneCode": that.verifiyCode
                })

                if (ResualtData.StatusCode == "0") {
                    that.$store.dispatch("LoaderPage", false)
                    that.$store.commit(TYPES.ALERT_TIP, {
                        show: true,
                        content: "设置密码成功"
                    });
                    window.jumpLink('/Member/MyCenter', '_router');
                } else {
                    if (ResualtData.Message == "未登录") {
                        //   clearUser();
                    }
                    that.$store.dispatch("LoaderPage", false)
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

        },
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.changePasswordBlock {
    padding: 0.25rem 0.65rem 20% 0.65rem;
    position: relative;
    color: $white;
    .a_block {
        text-align: left;
        padding: 1.5rem 0 0.8rem;
        color: #000000;
        font-size: 0.75rem;
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
                input {
                    font-size: 0.65rem;
                    background-color: $white;
                    width: 100%;
                    height: 2.1rem;
                    line-height: 2.1rem;
                    padding: 0 0.4rem;
                    border-radius: 8px;
                    color: #333333;
                }
                .iconfont {
                    font-size: 1.1rem;
                    position: absolute;
                    top: 0.25rem;
                    right: 0.1rem;
                    line-height: 1.2rem;
                    &.icon-guanbi1 {
                        opacity: 0.6;
                        color: #cccccc;
                        font-size: 0.85rem;
                    }
                }
                .getCode {
                    position: absolute;
                    top: 0;
                    right: 0.4rem;
                    color: #ed1721;
                    font-style: normal;
                    line-height: 2.1rem;
                    &.add {
                        // color: #959595;
                        width: 2rem;
                        text-align: center;
                        > img {
                            width: 1.1rem;
                        }
                        // &::before {
                        //     content: "";
                        //     height: 0.55rem;
                        //     width: 1px;
                        //     position: absolute;
                        //     left: -0.5rem;
                        //     top: 0.15rem;
                        //     background: #1c1c1c;
                        // }
                    }
                }
            }
        }
    }
    .agreeContract {
        color: #979797;
        height: 1.5rem;
        text-align: center;
        margin-top: 1.25rem;
        span {
            color: #fdc00d;
        }
        .icon-duihao11 {
            color: red;
        }
        .icon-yuanquan {
            color: #372d21;
        }
    }
    .inputWrap {
        width: 100%;
        margin: 2.25rem auto;
        input {
            font-size: 0.8rem;
            border: none;
            border-radius: 0.3rem;
            height: 1.9rem;
            letter-spacing: 3px;
            // box-shadow: 0 0px 2px rgba($color: #ffc21f, $alpha: 1);
        }
        .submit {
            background: #ed1721;
            color: #fff;
        }
    }
    .passwordLogin {
        margin-top: 1.25rem;
        text-align: center;
        a {
            color: #eec605;
        }
    }
    .alertMSG {
        color: #252525;
        text-align: center;
        margin-top: 1.5rem;
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

