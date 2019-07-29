<template>
    <f7-page>
        <div class="myCenter">
            <div class="topWrap">
                <div class="avtarBox" @click="jumpLink">
                    <div class="logInBtn"><img :src="avtar" alt=""></div>
                    <div class="logInmsg" v-if="!UserInfo">点击登录</div>
                    <div class="logInmsg" v-else>
                        {{UserInfo.Phone}}
                    </div>
                </div>
            </div>
            <div class="ContentWrap">
                <ul class="msgList">
                    <li @click="jumpLinks('/Member/WithDraw')">
                        <img :src="Iconimg1" alt="">
                        <p>立即提现</p>
                        <i v-if="UserInfo&&balance" class="icon iconfont icon-jiaobiao"></i>
                        <span v-if="balance">{{balance}}元</span>
                    </li>
                    <li @click="jumpLinks('/CN/BillingRecord')">
                        <img :src="Iconimg2" alt="">
                        <p>账单记录</p>
                    </li>
                    <li @click="jumpLinks('/CN/BillingStatus')">
                        <img :src="Iconimg3" alt="">
                        <p>提款状态</p>
                    </li>
                </ul>
            </div>
            <!-- <div class="promotion" @click="jumpLinks('/Member/PostIt')">
                <img :src="promotion" alt="">
            </div> -->
            <div class="mainWrap">
                <a href="javascript:;" @click="jumpLinks('/CN/ChangePassword')">
                    <i class="icon iconfont icon-jjshmima"></i>
                    <span>设置密码</span>
                    <i class="icon    iconfont icon-jiantou"></i>
                </a>
                <a href="javascript:;" @click="jumpLinks('/CN/UpdateInfo')">
                    <i class="icon iconfont icon-shuxie"></i>
                    <span>完善资料</span>
                    <i class="icon    iconfont icon-jiantou"></i>
                </a>
                <a href="javascript:;" @click="jumpLinks('/CN/PrivacyPolicy')">
                    <i class="icon iconfont icon-suo"></i>
                    <span>隐私政策</span>
                    <i class="icon iconfont icon-jiantou"></i>
                </a>
                <a href="javascript:;" @click="jumpLinks('/CN/ContactService')">
                    <i class="icon iconfont icon-kefu2"></i>
                    <span>联系客服</span>
                    <i class="icon iconfont icon-jiantou"></i>
                </a>
                <a href="javascript:;" @click="jumpLinks('/CN/FrequentProblems')">
                    <i class="icon iconfont icon-questionMark"></i>
                    <span>常见问题</span>
                    <i class="icon iconfont icon-jiantou"></i>
                </a>
            </div>
            <div class="mainWrap" v-if="UserInfo">
                <p class="loginOut" @click="loginOut">退出登录</p>
            </div>
            <div class="edition">
                <p>V：1.0.0</p>
            </div>
        </div>
        <toolbar></toolbar>
    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, isiOS } from "@/config/env";
import Commonnavbar from "@/components/wap/common/Commonnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from 'js-cookie'
import toolbar from "@/components/wap/common/toolbar";

let cache = new wsCache();
export default {
    data() {
        return {
            isiOS,
            avtar: buildImg(require("@/assets/wap/images/login/avtar.png")),
            Iconimg1: buildImg(require("@/assets/wap/images/Login/Iconimg1.png")),
            Iconimg2: buildImg(require("@/assets/wap/images/Login/Iconimg2.png")),
            Iconimg3: buildImg(require("@/assets/wap/images/Login/Iconimg3.png")),
            // promotion: buildImg(require("@/assets/wap/images/Login/promotion.png")),
            balance: ""
        }
    },
    created() {
        if (this.UserInfo) {
            this.GetMyAvailableBalance()
        }


    },
    computed: {
        ...mapGetters(["UserInfo", "deviceUuid", 'clientContact', "verifiyCode"])
    },
    components: {
        toolbar
    },
    methods: {

        jumpLink(url) {
            if (this.UserInfo) {
                window.jumpLink('/CN/UpdateInfo', '_router')
            } else {
                window.jumpLink('/CN/Login', '_router')
            }

        },
        jumpLinks(params) {
            // if (params == "客服") {
            //     if (isiOS) {
            //         window.jumpLink(
            //             `${this.clientContact}`,
            //             "_default",
            //             null,
            //             "PORTRAIT"
            //         );
            //     } else {
            //         window.jumpLink(
            //             `${this.clientContact}`,
            //             "_system",
            //             null,
            //             "PORTRAIT"
            //         );
            //     }
            // } else {
            window.jumpLink(params, '_router')
            // }

        },
        async GetMyAvailableBalance() {
            let that = this;
            let Result = await this.$store.dispatch('GetMyAvailableBalance');
            if (Result.StatusCode == "0") {
                this.balance = Result.Data
            } else {
                if (Result.Message == "未登录") {
                    clearUser();
                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: Result.Message
                });
                return
            }
        },
        loginOut() {
            const that = this;
            clearUser()
            that.$store.commit(TYPES.ALERT_TIP, {
                show: true,
                content: `您已安全退出会员账号，非常感谢！`,
            })
            window.jumpLink('/Member/Home', '_router');
        }
    }


};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.myCenter {
    // background: #f5f5f5;
    // height: 100%;
    // overflow: scroll;
}
.topWrap {
    background: #f22b33;
    position: relative;
    padding: 0.6rem 0.4rem 2.5rem;
    .avtarBox {
        .logInBtn {
            display: inline-block;

            > img {
                width: 2.8rem;
                vertical-align: middle;
            }
        }
        .logInmsg {
            font-size: 0.65rem;
            display: inline-block;
            padding-left: 0.3rem;
            color: #fff;
        }
    }
}
.ContentWrap {
    transform: translateY(0);
    margin-top: -1.5rem;
    .msgList {
        display: flex;
        background: #ffffff;
        margin: 0 0.6rem;
        text-align: center;
        border-radius: 10px;
        padding: 0.8rem 0;
        // box-shadow: 0 2px 0 #fff9e0;
        li {
            flex: 1;
            position: relative;
            .iconfont {
                position: absolute;
                top: -0.5rem;
                right: -0.35rem;
                color: red;
                font-size: 0.8rem;
                width: 2rem;
                height: 1.25rem;
                display: block;
            }
            span {
                position: absolute;
                top: -0.4rem;
                right: -0.45rem;
                color: white;
                font-size: 0.48rem;
                width: 2rem;
                height: 1.25rem;
                line-height: 0.8rem;
                text-align: center;
            }
            img {
                width: 55%;
            }
        }
    }
    // &.android {
    //     .msgList {
    //         display: flex;
    //         width: 100%;
    //         transform: translate(0, 0);
    //         background: #ffffff;
    //         margin: 0 auto;
    //         text-align: center;
    //         border-radius: 0;
    //         padding: 0.25rem 0;
    //         box-shadow: 0 0 0 #fff9e0;
    //         li {
    //             flex: 1;
    //             img {
    //                 width: 40%;
    //             }
    //         }
    //     }
    // }
}
// .promotion {
//     padding: 0.35rem 0.65rem;

//     img {
//         width: 100%;
//         transform: translate(0, -10%);
//     }
// }
.mainWrap {
    background: #fff;
    padding: 0.3rem 0.4rem 0.3rem 0.8rem;
    margin: 0.6rem;
    border-radius: 10px;
    &.add {
        padding-top: 0.75rem;
    }
    a {
        display: block;
        text-align: left;
        // border-bottom: 1px solid #eeeeee;
        height: 1.9rem;
        line-height: 1.9rem;
        position: relative;
        .icon-jjshmima {
            color: #f2a42a;
        }
        .icon-shuxie {
            color: #67d922;
        }
        .icon-suo {
            color: #2fb3f0;
        }
        .icon-kefu2 {
            background: url(../../../assets/wap/images/login/icon_customer_default.png)
                no-repeat center;
            background-size: contain;
            width: 0.7rem;
            height: 100%;
        }
        .icon-questionMark {
            background: url(../../../assets/wap/images/login/icon_questionMark_default.png)
                no-repeat center;
            background-size: contain;
            width: 0.7rem;
            height: 100%;
        }
        span {
            display: inline-block;
            padding-left: 0.25rem;
        }
        .icon-jiantou {
            color: #999999;
            position: absolute;
            top: 0.1rem;
            right: 0.25rem;
        }
    }
    .loginOut {
        width: 80%;
        margin: 1.2rem auto;
        background: #f22b33;
        height: 1.5rem;
        line-height: 1.5rem;
        border-radius: 1.5rem;
        text-align: center;
        color: #ffffff;
        font-size: 0.65rem;
    }
}
.edition{
    font-size:0.46rem;
    text-align: center;

}
</style>

