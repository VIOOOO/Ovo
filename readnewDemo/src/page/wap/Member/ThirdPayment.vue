<template>
    <f7-page class="thirdPayment">
        <navbar title="提现" back="AnimationBack"></navbar>
        <section class="WithDraw">
            <div class="header">
                <!-- <i class="icon iconfont icon-gantanhao--"></i> -->
                提示:选择某商家,联系客服去取现;选择的第三方和天宇头条没有任何联系,请保管好自己的钱包余额!
            </div>
            <ul class="paylist">
                <li v-for="(item,index) in list" :key="index" @click="jumpLink(item)">
                    <img :src="item.img" alt="">
                    <p class="name">{{item.name}}</p>
                    <p class="num">{{item.num}}</p>
                    <a href="javascript:;" class="withdrawEvent">立即提现</a>
                </li>
            </ul>
        </section>

    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, realNamePattern } from "@/config/env";
import navbar from "@/components/wap/common/nosearchnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from 'js-cookie'

let cache = new wsCache();
export default {
    data() {
        return {
            ClickMark: true,
            QQpay: buildImg(require("@/assets/wap/images/pay/QQpay.png")),
            moneyNum: "",
            list: [
                {
                    name: "美图秀秀",
                    img: buildImg(require("@/assets/wap/images/pay/imgs1.png")),
                    num: "12098"
                },
                {
                    name: "剑与家园：妖精重生",
                    img: buildImg(require("@/assets/wap/images/pay/imgs2.png")),
                    num: "32567"
                },
                {
                    name: "美图秀秀",
                    img: buildImg(require("@/assets/wap/images/pay/imgs3.png")),
                    num: "246"
                }
            ]

        }
    },
    created() {

    },
    computed: {
        ...mapGetters(["UserInfo", "CustomAlertTip", "PhoneNum", "deviceUuid", "verifiyCode"])
    },
    components: { navbar },
    methods: {
        jumpLink(params) {
            this.$store.commit('WithdrawalMethod', params.name)
            window.jumpLink('/Member/AddUserBank', '_router');
        },
        jumpLinks(params) {
            window.jumpLink(params, '_router');
        }
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.WithDraw {
    .header {
        background: #fcecec;
        // height: 2.5rem;
        font-size: 0.45rem;
        padding: 0.35rem 0.65rem;
        color: #ed1721;
        // line-height: 0.85rem;
        // padding-left: 1.85rem;
        position: relative;

        // .icon-gantanhao-- {
        //     color: red;
        //     font-size: 0.8rem;
        //     position: absolute;
        //     top: 0.3rem;
        //     left: 0.65rem;
        // }
    }
    .paylist {
        width: 92%;
        margin: 0.25rem auto;
        li {
            position: relative;
            height: 2.75rem;
            border-bottom: 1px solid #eeeeee;
            img {
                position: absolute;
                top: 0.45rem;
                left: 0rem;
                width: 13.5%;
            }
            .name {
                position: absolute;
                top: 0.45rem;
                left: 20%;
                font-size: 0.65rem;
            }
            .num {
                position: absolute;
                bottom: 0.5rem;
                left: 20%;
                color: #999999;
            }
            .withdrawEvent {
                position: absolute;
                right: 0;
                top: 0.75rem;
                width: 3.5rem;
                height: 1.15rem;
                border-radius: 3px;
                line-height: 1.15rem;
                text-align: center;
                border: 1px solid #ed1721;
                color: #ed1721;
            }
        }
    }
    // .inputWrap {
    //     width: 96%;
    //     margin: 1rem auto;
    //     input {
    //         font-size: $font_rem_big;
    //         font-weight: bold;
    //         border: none;
    //         border-radius: 1.75rem;
    //         height: 1.75rem;
    //         box-shadow: 0 0px 2px rgba($color: #ffc21f, $alpha: 1);
    //     }
    //     .submit {
    //         background: linear-gradient(to bottom, #ffc21f, #ffc21f);
    //         color: #372d21;
    //     }
    // }
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

