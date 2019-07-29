<template>
    <f7-page class="register">
        <div class="section">
            <div class="a_block">
                <div class="logoBlock">
                    <img class="logo" :src="logoIcon" alt="" srcset="">
                </div>
            </div>
            <div class="b_block">
                <div class='title'>
                    <p>代理账号注册</p>
                </div>
                <div class='applyTable'>
                    <table>
                        <tr>
                            <td class="first-col">账号：</td>
                            <td class="second-col loginname">
                                <span class='loginPre'>{{prefix}}</span>
                                <input type="text" v-focus :class="{'input-error':errors.userName}" v-model="userName" maxlength="9" placeholder="请输入6-9个字符" @blur="checkUserName" v-inputprevent name="loginname" ref="loginname">
                                <i class="iconfont" :class="{'icon-close':userName.length}" @click="userName=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.userName">
                                    <p class="errorMsg">{{errorMessage.userName}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">密码：</td>
                            <td class="second-col">
                                <input type="password" :class="{'input-error':errors.passWord}" v-model="passWord" maxlength="16" placeholder="请输入6-16个字符" @blur="checkPwdStr" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':passWord.length}" @click="passWord=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.passWord">
                                    <p class="errorMsg">{{errorMessage.passWord}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">确认密码：</td>
                            <td class="second-col">
                                <input type="password" :class="{'input-error':errors.repPassWord}" v-model="repPassWord" maxlength="16" placeholder="请再一次确认密码" @blur="checkRepPwdStr" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':repPassWord.length}" @click="repPassWord=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.repPassWord">
                                    <p class="errorMsg">{{errorMessage.repPassWord}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">联系人：</td>
                            <td class="second-col">
                                <input type="text" :class="{'input-error':errors.realName}" v-model="realName" maxlength="6" placeholder="请输入中文真实姓名" @blur="checkRealName" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':realName.length}" @click="realName=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.realName">
                                    <p class="errorMsg">{{errorMessage.realName}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">联系电话：</td>
                            <td class="second-col">
                                <input type="text" :class="{'input-error':errors.contactNo}" v-model="contactNo" maxlength="11" placeholder="请输入手机号码" @blur="checkContactNo" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':contactNo.length}" @click="contactNo=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.contactNo">
                                    <p class="errorMsg">{{errorMessage.contactNo}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">电子邮箱：</td>
                            <td class="second-col password eMailAdd">
                                <input type="text" :class="{'input-error':errors.eMailAdd}" v-model="eMailAdd" maxlength="30" placeholder="请输入电子邮箱" @blur="checkEMailAdd" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':eMailAdd.length}" @click="eMailAdd=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.eMailAdd">
                                    <p class="errorMsg">{{errorMessage.eMailAdd}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">QQ：</td>
                            <td class="second-col">
                                <input type="text" :class="{'input-error':errors.qqNumber}" v-model="qqNumber" @blur="checkQQNumber" maxlength="11" placeholder="请输入QQ号码" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':qqNumber.length}" @click="qqNumber=''"></i>
                                <span class='tailStar'>*</span>
                                <transition name='eMsgShow' v-if="errors.qqNumber">
                                    <p class="errorMsg">{{errorMessage.qqNumber}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">详细说明：</td>
                            <td class="second-col">
                                <textarea class='textBook' rows="4" v-model="texarea"></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">邀请码：</td>
                            <td class="second-col">
                                <input type="text" :class="{'input-error':errors.invitation}" v-model="invitation" @blur="checkInvitation" maxlength="20" placeholder="请输入邀请码" v-inputprevent>
                                <i class="iconfont" :class="{'icon-close':invitation.length}" @click="invitation=''"></i>
                                <transition name='eMsgShow' v-if="errors.invitation">
                                    <p class="errorMsg">{{errorMessage.invitation}}</p>
                                </transition>
                            </td>
                        </tr>

                        <tr>
                            <td class="first-col">验证码：</td>
                            <td class="second-col password verifyCode">
                                <input type="text" placeholder="输入证码" v-model="verifyCode" @blur="checkVerifyCode" maxlength="6" v-inputprevent>
                                <img class="capthaImage" :src="validation.imageCode" title="换一张" @click="renewCaptcha">
                                <span class='tailStar'>*</span>
                                <div v-show="loadingWaveShow" class="loadingWave">
                                    <div class="help"></div>
                                </div>
                                <transition name='eMsgShow' v-if="errors.verifyCode">
                                    <p class="errorMsg">{{errorMessage.verifyCode}}</p>
                                </transition>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="inputWrap">
                    <div>
                        <input class="col button button-fill reset" type="button" value="重  置" @click="resetForm">
                    </div>
                    <div>
                        <input class="col button button-fill submit" type="button" :value="ClickMark?'注  册':'注册中...'" @click="submitForm">
                    </div>
                </div>
            </div>
            <f7-link class="login" @click="$_linkUrl('/CN/Login', '_router')">登录</f7-link>

            <!-- 全屏loader -->
            <loaderPage :bgBlack="true"></loaderPage>
        </div>
    </f7-page>
</template>

<script>
import { prefix, realNamePattern, numbersAndLetters, onlyLetters, passwordPattern, contactNoPattern, emailPattern, qqPattern, buildImg,clearUser } from "@/config/env";
import { mapGetters, mapActions } from "vuex";
import { trimString } from "@/config/math";
import TYPES from "@/store/mutation-types";
import loaderPage from '@/components/wap/common/loaderPage'
import wsCache from "web-storage-cache";

let cache = new wsCache();
export default {
    data() {
        return {
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            preUrl: "",
            prefix,
            userName: "",   //账号
            passWord: "",   //密码
            repPassWord: "",    //重复密码
            realName: "",   //联系人
            contactNo: "",  //联系电话
            eMailAdd: "",   //邮箱
            qqNumber: "",   //QQ
            texarea: "",     //详细说明
            invitation: '',  //邀请码
            verifyCode: "", //验证码
            termsAccept: true,
            ClickMark: true,
            loadingWaveShow: false,
            validation: {
                id: '',
                imageCode: ''
            },
            errors: {
                //All Error Flags Start with Null to avoid false positive validity
                userName: null,
                passWord: null,
                repPassWord: null,
                realName: null,
                contactNo: null,
                eMailAdd: null,
                qqNumber: null,
                invitation: false,
                verifyCode: null
            },
            errorMessage: {
                userName: "账号长度必须在6-9个字符",
                passWord: "密码长度必须在6-16个字符,不能有特殊字符",
                repPassWord: "两次输入的密码不一致！",
                realName: "真实姓名请输入中文！",
                contactNo: "请输入正确格式的手机号码！",
                eMailAdd: "请输入正确格式的电子邮箱！",
                qqNumber: "请检查QQ是否正确！",
                invitation: '邀请码，不能有特殊字符',
                verifyCode: "请输入验证码"
            },
            showHints: {
                userName: false,
                // passWord: false,
                // repPassWord: false,
                // realName: false,
                // eMailAdd: false
            },
            hintMessage: {
                userName: "用户名由英文和数字组成（不能为纯数字）",
                passWord: "密码长度必须在6-16个字符,不能有特殊字符",
                repPassWord: "两次输入的密码不一致！",
                realName: "真实姓名必须与取款时提款人名一致",
                eMailAdd: "请输入正确格式的电子邮箱！",
                qqNumber: "QQ号码，只能输入数字",
                verifyCode: "验证码不能输入特殊字符"

            }
        };
    },
    created() {
        const that = this;
        that.$nextTick(() => {
            that.renewCaptcha()
            // setTimeout(() => {
            //     that.preUrl = this.$f7Router.previousRoute.url == '/CN/Login' ? '/CN/Login' : this.$f7Router.previousRoute.url;
            // }, 0);
        })

    },
    watch: {
        contactNo() {
            this.contactNo = this.contactNo.length > 11 ? this.contactNo.substring(0, 11) : this.contactNo;
            if (!trimString(this.contactNo)) {
                this.errors.contactNo = false;
            }
        }
    },
    computed: {
        // ...mapGetters(["WapRegister"]),
        formHasErrors() {
            return Object.keys(this.errors).some(function (k, i, a) {
                return this.errors[k] === true || this.errors[k] === null;
            }, this);
        }
    },
    methods: {
        async renewCaptcha() {
            const that = this;
            if (that.loadingWaveShow) return
            try {
                that.loadingWaveShow = true;
                let getVCode = await that.$store.dispatch('GetValidationCode')
                that.validation.id = getVCode.id;
                that.validation.imageCode = getVCode.image;
                that.loadingWaveShow = false;
            }
            catch (e) {
            }
        },
        resetForm() {
            this.userName = '';
            this.passWord = '';
            this.repPassWord = '';
            this.realName = '';
            this.contactNo = '';
            this.eMailAdd = '';
            this.contactNo = '';
            this.verifyCode = '';
            this.qqNumber = '';
        },
        checkUserName() {
            const that = this;
            let newVal = this.userName;
            that.showHints.userName = newVal.length == 0 ? true : false;
            if (that.showHints.userName) {
                that.errors.userName = true;
                return;
            }

            /**只能数字和字母（不能为纯数字） */
            if (numbersAndLetters.test(newVal) && !/^[0-9]+$/.test(newVal)) {
                that.errors.userName = false;
            } else {
                that.errorMessage.userName = that.hintMessage.userName;
                that.errors.userName = true;
                return;
            }

            if (newVal.length < 6 || newVal.length > 9) {
                that.errorMessage.userName = "用户名必须是6-9位字母和数字组合";
                that.errors.userName = true;
            } else {
                that.errors.userName = false;
                that.$store.dispatch('IsExisted', {
                    "agentUserName": that.prefix + that.userName.replace(/ /g, '')
                }).then(data => {
                    if (data.passed) {
                        that.errorMessage.userName = "代理已存在，请重新输入";
                        that.errors.userName = true;
                    }
                });
            }
        },
        checkPwdStr() {
            if (!passwordPattern.test(this.passWord)) {
                this.errorMessage.passWord = this.hintMessage.passWord;;
                this.errors.passWord = true;
                return false;
            } else {
                this.errors.passWord = false;
            }
            return true;
        },
        checkRepPwdStr() {
            if (this.passWord != this.repPassWord) {
                this.errorMessage.repPassWord = this.hintMessage.repPassWord;
                this.errors.repPassWord = true;
            } else {
                this.errors.repPassWord = false;
            }
        },
        checkRealName() {
            if (!realNamePattern.test(this.realName)) {
                this.errors.realName = true;
            } else {
                this.errors.realName = false;
            }
        },
        checkEMailAdd() {
            if (!emailPattern.test(this.eMailAdd)) {
                this.errors.eMailAdd = true;
            } else {
                this.errors.eMailAdd = false;
            }
        },
        checkContactNo() {
            if (!contactNoPattern.test(this.contactNo)) {
                this.errors.contactNo = true;
            } else {
                this.errors.contactNo = false;
            }
        },
        checkQQNumber() {
            if (!qqPattern.test(this.qqNumber)) {
                this.errorMessage.qqNumber = this.hintMessage.qqNumber;
                this.errors.qqNumber = true;
            } else {
                this.errors.qqNumber = false;
            }
        },
        checkInvitation() {
            if (!numbersAndLetters.test(this.invitation) && this.invitation.replace(/ /g, "")) {
                this.errors.invitation = true;
            } else {
                this.errors.invitation = false;
            }
        },
        checkVerifyCode() {
            if (!numbersAndLetters.test(this.verifyCode)) {
                this.errorMessage.verifyCode = this.hintMessage.verifyCode;
                this.errors.verifyCode = true;
            } else {
                this.errors.verifyCode = false;
            }
        },

        async submitForm() {
            const that = this;

            //判断必填
            if (
                !that.userName.replace(/ /g, '') ||
                !that.passWord.replace(/ /g, '') ||
                !that.repPassWord.replace(/ /g, '') ||
                !that.realName.replace(/ /g, '') ||
                !that.contactNo.replace(/ /g, '') ||
                !that.eMailAdd.replace(/ /g, '') ||
                !that.qqNumber.replace(/ /g, '') ||
                !that.verifyCode.replace(/ /g, '')
            ) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "注册帐号",
                    content: "带星号为必填内容"
                });
                return;
            }

            // 判断是否全部都填写格式正确
            if (that.formHasErrors) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "注册帐号",
                    content: "请正确输入注册信息。"
                });
                return;
            }

            if (that.ClickMark) {
                that.ClickMark = false;
                that.$store.dispatch("LoaderPage", true)
                try {
                    let regDis = await that.$store.dispatch('Register', {
                        "UserName": that.prefix + that.userName.replace(/ /g, ''),
                        "Password": that.passWord.replace(/ /g, ''),
                        "Password_confirm": that.repPassWord.replace(/ /g, ''),
                        "TrueName": that.realName,
                        "Tel": trimString(that.contactNo),
                        "Email": that.eMailAdd,
                        "QQ": that.qqNumber,
                        "ValidationID": that.validation.id,
                        "ValidationCode": that.verifyCode,
                        "InviteCode": that.invitation,
                        "Content": that.texarea,
                        "ComeFrom":location.host
                    })
                    // let loginDis = await that.$store.dispatch('Login', {
                    //     "UserName": that.prefix + that.userName.replace(/ /g, ''),
                    //     "Password": that.passWord.replace(/ /g, ''),
                    // })
                    //记住密码
                    cache.delete("memberlogin");
                    cache.set("memberlogin", {
                        loginname: that.userName.replace(/ /g, ''),
                        password: that.passWord.replace(/ /g, '')
                    });
                    that.$store.dispatch("LoaderPage", false);
                    that.ClickMark = true;
                    // console.log(loginDis)
                    that.$store.commit(TYPES.ALERT_TIP, {
                        show: true,
                        content: regDis,
                        close: false,
                        ok: true,
                        oktext: "确定",
                        success: () => {
                            that.$store.commit(TYPES.ALERT_TIP, {
                                show: false,
                                close: true,
                            })
                            window.jumpLink('/CN/Login', '_router');
                        }
                    })

                }
                catch (e) {
                    that.$store.dispatch("LoaderPage", false)
                    that.ClickMark = true;
                }
            }
        },
        $_linkUrl(url, way) {
            const that = this;
            window.jumpLink(url, way)
        }
    },
    components: {
        loaderPage
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.register {
    // background: linear-gradient(#aa0001, #f30008);
    .section {
        position: relative;
        color: $white;
        .a_block {
            .backs {
                position: absolute;
                width: 2rem;
                height: 2rem;
            }
            .logoBlock {
                text-align: center;
                padding: 1.5rem 0 0.8rem;
                .logo {
                    width: 4.5rem;
                }
            }
        }
        .b_block {
            .title {
                text-align: center;
                font-size: 0.75rem;
                > p {
                    width: 9rem;
                    margin: 0 auto;
                    padding: 0.2rem 0;
                    border-bottom: 1px solid #ce9f9f;
                }
            }
            .applyTable {
                padding: 0.6rem 0 1.2rem;
                table {
                    width: 90%;
                    margin: 0 auto;
                    tr {
                        td {
                            padding-top: 0.3rem;
                            &.first-col {
                                text-align: right;
                                padding-right: 0.2rem;
                            }
                            &.second-col {
                                position: relative;
                                width: 10rem;
                            }
                        }
                    }
                }
                input {
                    background: $white;
                    width: 8rem;
                    line-height: 1.2rem;
                    padding: 0 0.2rem;
                    color: $font_color;
                    border-radius: 2px;
                    &.input-error {
                        color: $red_low;
                    }
                }
                .iconfont {
                    font-size: 1.1rem;
                    position: absolute;
                    top: 0.3rem;
                    right: 2.2rem;
                    line-height: 1.2rem;
                    opacity: 0;
                    &.icon-close {
                        opacity: 0.5;
                    }
                    color: $font_color;
                }
                .errorMsg {
                    font-size: $font_rem_small;
                    color: $font_color03;
                }
                .tailStar {
                    position: absolute;
                    top: 0.6rem;
                    right: 1.2rem;
                }
                .loginname {
                    .loginPre {
                        position: absolute;
                        display: inline-block;
                        width: 1.6rem;
                        height: 1.2rem;
                        line-height: 1.2rem;
                        font-size: $font_rem_large;
                        text-align: center;
                        color: $font_color;
                        i {
                            font-size: 1.2rem;
                            margin-top: -0.1rem;
                        }
                    }
                    .loginPre::after {
                        position: absolute;
                        content: "";
                        height: 70%;
                        width: 1px;
                        background: $gray_light;
                        right: 0.2rem;
                        top: 15%;
                    }
                    input {
                        padding-left: 1.7rem;
                    }
                }
                .textBook {
                    background-color: $white;
                    width: 8rem;
                    border-radius: 2px;
                    color: $font_color;
                    padding: 0.1rem 0.2rem;
                }
                .verifyCode {
                    input {
                        width: 4.3rem;
                        display: inline-block;
                        // letter-spacing: 0;
                    }
                    .capthaImage {
                        position: absolute;
                        left: 47%;
                        width: 3.2rem;
                        height: 1.2rem;
                    }
                }
            }
        }
        .inputWrap {
            width: 75%;
            margin: 0 auto;
            padding-bottom: 4rem;
            div + div {
                margin-left: 4%;
            }
            > div {
                display: inline-block;
                width: 46%;
                input {
                    font-size: $font_rem_large;
                    font-weight: bold;
                    border: none;
                    border-radius: 0.1rem;
                    height: 1.7rem;
                    box-shadow: 1px 1px 1px $gray_dim;
                }
                .submit {
                    background: $white;
                    color: $peru;
                }
                .reset {
                    background: #0084ff;
                    // color: $yellow_low;
                }
            }
        }
        .login {
            background: #7b69ed;
            position: absolute;
            display: inline-block;
            right: 0.2rem;
            bottom: 0.35rem;
            width: 2.4rem;
            height: 2.4rem;
            line-height: 2.4rem;
            border-radius: 4rem;
            text-align: center;
            z-index: $zindex_regular;
            color: $white;
        }
        // .login::before {
        //     content: "";
        //     position: absolute;
        //     left: 0.2rem;
        //     top: 0.2rem;
        //     width: 2rem;
        //     line-height: 2rem;
        //     text-align: center;
        //     height: 2rem;
        //     color: $white;
        //     font-size: $font_rem_large;
        //     border-radius: 2rem;
        //
        // }
    }
    .loadingWave {
        position: absolute;
        top: 0.7rem;
        right: 1.3rem;
        width: 30px;
        height: 30px;
        .help {
            width: 26px;
            height: 26px;
            border: 1px #fffacb solid;
            border-radius: 50%;
            -webkit-animation: rotation 1s ease-in-out infinite;
            -moz-animation: rotation 1s ease-in-out infinite;
            animation: rotation 1s ease-in-out infinite;
            margin: 2px auto;
        }
        .help:after {
            background-color: #cddc39;
            border-radius: 100%;
            content: "";
            position: absolute;
            width: 6px;
            height: 6px;
        }
        @-webkit-keyframes rotation {
            0% {
                -webkit-transform: rotate(0deg);
            }
            100% {
                -webkit-transform: rotate(360deg);
            }
        }
        @-moz-keyframes rotation {
            0% {
                -moz-transform: rotate(0deg);
            }
            100% {
                -moz-transform: rotate(360deg);
            }
        }
        @keyframes rotation {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    }
    .eMsgShow-enter-active {
        transition: all 2s;
        opacity: 1;
        height: 0.7rem;
    }

    .eMsgShow-leave-active {
        transition: all 0.5s;
        opacity: 1;
        height: 0.7rem;
    }
    .eMsgShow-enter,
    .eMsgShow-leave-to {
        opacity: 0;
        height: 0;
    }
}
</style>
<style>
.ios .page.register .page-content {
    background: linear-gradient(#aa0001, #f30008);
}
</style>
