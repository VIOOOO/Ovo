<template>
    <f7-page class="login">
        <navbar title="提现" back="/Member/MyCenter"></navbar>
          <section class="WithDraw">
            <div class="header">
                <p>目前账户可用余额</p>
                <h3>￥{{balance}}</h3>
                <!-- <a href="javascript:;" class="blanceHistory">提现记录</a> -->
            </div>
            <div class="main">
                <div class="withDrawMethod">
                    <p class="drawMethodTitle">提现方式</p>
                    <ul class="payChoice">
                        <li class="payCut"><img :src="QQpay" alt=""></li>
                    </ul>
                    <p class="drawMethodTitle">提现金额</p>
                    <h4>
                        <input type="text" value="" @input="handleInput" v-model="moneyNum" placeholder="请输入您的提现金额">
                    </h4>
                    <div class="alert">
                        <p>注意事项:</p>
                        <p>1.提现申请将在24小时后审批到账,请耐心等待</p>
                        <p>2.请及时关注 "我的>提现记录"查看提现记录状态</p>
                        <p>3.天宇头条仅核实商户是否给您打款,其他责任跟该平台无关</p>
                    </div>
                </div>
                <div class="inputWrap">
                    <input class="col button button-fill submit" @click="UserBalanceChangesEvent" type="button" :value="ClickMark?'提现':'提交中...'">
                </div>
            </div>
        </section>

    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser ,realNamePattern} from "@/config/env";
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
            balance: ""

        }
    },
    created() {
        this.GetMyAvailableBalance();
    },
    computed: {
        ...mapGetters(["UserInfo", "CustomAlertTip", "PhoneNum", "deviceUuid", "verifiyCode", "WithdMoNey"])
    },
    components: {navbar},
    methods: {
        jumpLink() {
            window.jumpLink('/Member/MyCenter', '_router');
        },
        handleInput(e) {
            this.moneyNum = e.target.value.replace(/[^\d]/g, '');
        },
        async GetMyAvailableBalance() {
            let ResualtData = await this.$store.dispatch('GetMyAvailableBalance');
            if (ResualtData.StatusCode == "0") {
                this.balance = ResualtData.Data
            } else {
                if (ResualtData.Message == "未登录") {
                    clearUser();

                }
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: ResualtData.Message
                });
                return
            }
        },
        async UserBalanceChangesEvent() {
            let that = this;
            if (this.UserInfo && this.moneyNum > this.balance) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `输入金额大于账户余额请重新输入`
                });
                return;
            }
            if (this.moneyNum == 0) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `请输入您要提现的金额`
                });
                return;
            }
            this.$store.commit("WithdMoNey", this.moneyNum)
            window.jumpLink('/Member/ThirdPayment', '_router');

        },

    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.WithDraw {
    background:#fff;
    height:100%;
    .main {
        padding: 0 0.65rem;
        .withDrawMethod {
            .drawMethodTitle {
                padding: 0.7rem 0 0.35rem;
            }
            //   img{
            //     width: 35%;
            //   }
            // h4 {
            //     padding: 0.25rem 0;
            // }
            input {
                font-size: 0.72rem;
                display: block;
                width: 100%;
                line-height: 2.2rem;
                padding: 0 0.45rem;
                border: 1px solid #ed1721;
                border-radius: 8px;
            }
            .payChoice {
                > li {
                    width: 35%;
                    position: relative;
                    border: 1px solid transparent;
                    border-radius: 8px;
                    > img {
                        width: 100%;
                        vertical-align: middle;
                    }
                    &.payCut {
                        border-color: #ed1721;
                        &::before {
                            background: url(../../../assets/wap/images/pay/payIcon.png)
                                no-repeat top left;
                            background-size: 100% auto;
                            content: "";
                            position: absolute;
                            left: 0;
                            top: 0;
                            width: 1rem;
                            height: 1rem;
                        }
                    }
                }
            }
            .alert {
                padding: 0.75rem 0;
                color: #666;
                > p {
                    line-height: 0.9rem;
                }
            }
        }
    }
    .header {
        background: #f5f5f5;
        // height: 2.25rem;
        padding: 0.4rem 0.65rem 0.2rem;
        color: #333333;
        position: relative;
        .blanceHistory {
            position: absolute;
            top: 0.75rem;
            right: 0.65rem;
            color: #ffc000;
        }
        p {
            color: #969696;
        }
        h3 {
            font-weight: normal;
            font-size: 0.85rem;
            line-height: 1.5rem;
        }
    }
    .inputWrap {
        width: 96%;
        margin: 1rem auto;
        input {
            font-size: $font_rem_big;
            border: none;
            border-radius: 8px;
            height: 1.85rem;
            letter-spacing: 0.2rem;
            // box-shadow: 0 0px 2px rgba($color: #ffc21f, $alpha: 1);
        }
        .submit {
            background: #ed1721;
            color: #fff;
        }
    }
}
// 搜索栏

// .searchBox {
//     background: #ffffff;
//     display: flex;
//     width: 100%;
//     align-items: center;
//     justify-content: center;

//     li.leftSide {
//         flex: 1;
//         .icon-back-arrow {
//             color: #333;
//             font-size: 1.35rem;
//         }
//     }
//     li.rightSide {
//         flex: 20;
//         position: relative;
//         color: #030303;
//         text-align: center;
//         text-indent: -15%;
//         font-size: 0.7rem;
//         font-weight: bold;
//     }
// }
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>


