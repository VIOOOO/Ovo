<template>
    <f7-page class="billingStatus">
        <navbar title="提款状态" back="/Member/MyCenter"></navbar>
        <div class="billingStatusBlock">
            <div class="b_block" v-if="listResult.length>0">
                <div class="service" @click="jumpLink('/CN/ContactServiceCash')">
                    <span>联系客服加速提现</span>
                    <span><i class="iconser"></i>提现客服</span>
                </div>
                <div>
                    <!-- 状态： status:0 处理中；status:1  出款成功；status:10 拒绝出款 -->
                    <ul v-for=" (item,index) in listResult" :key="index">
                        <li class="" v-if="item.Status==1">
                            <div class="billLeft">
                                <!-- <i class="icon iconfont icon-ziyuan pay"></i> -->
                                <i class="icon iconfont icon-ziyuan get"></i>
                            </div>
                            <div class="billRight">
                                <div class="billUp">
                                    <p>{{item.Remark}}</p>
                                </div>
                                <div class="billDown">
                                    <em>{{new Date(item.ModifyTime).format("yyyy-MM-dd hh:mm:ss")}}</em>
                                    <span class="less">{{item.Balance}}</span>
                                </div>
                            </div>
                        </li>
                        <li v-if="item.Status==0||item.Status==10">
                            <div class="billLeft">
                                <!-- <i class="icon iconfont icon-ziyuan pay"></i> -->
                                <i class="icon iconfont icon-ziyuan get"></i>
                            </div>
                            <div class="billRight">
                                <div class="billUp">
                                    <p>{{item.Remark}}</p>
                                </div>
                                <div class="billDown">
                                    <em>{{new Date(item.ModifyTime).format("yyyy-MM-dd hh:mm:ss")}}</em>
                                    <span class="less">{{item.Balance}}</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="emptyBlock" v-else>
                暂无相关记录!
            </div>
        </div>
        <!-- 全屏loader -->
        <!-- <loaderPage :bgBlack="true"></loaderPage> -->
    </f7-page>
</template>

<script>
import {
    prefix,
    buildImg,
    cookie,
    numbersAndLetters,
    clearUser
} from "@/config/env";
import navbar from "@/components/wap/common/nosearchnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from "js-cookie";

let cache = new wsCache();
export default {
    data() {
        return {
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            loginIcon01: buildImg(
                require("@/assets/wap/images/Login/loginIcon01.png")
            ),
            loginIcon02: buildImg(
                require("@/assets/wap/images/Login/loginIcon02.png")
            ),
            listResult: [],
            balance: ""
        };
    },
    created() {
        this.UserBalanceChangesEvent();
    },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    components: { navbar },
    methods: {
        jumpLink(url) {
            window.jumpLink(url, "_router");
        },
        async UserBalanceChangesEvent() {
            let that = this;
            // debugger
            this.$store.dispatch("LoaderPage", true);
            let ResualtData = await this.$store.dispatch('UserWithdrawLog')
            this.$store.dispatch("LoaderPage", false);
            if (ResualtData.StatusCode == "0") {
                that.listResult = ResualtData.Data
            } else {
                if (ResualtData.Message == "未登录") {
                    // clearUser();
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
.billingStatus {
    .billingStatusBlock {
        background: #fff;
        height: 100%;
        overflow: scroll;
        position: relative;
        color: $white;
        padding-bottom: 2.5rem;
        .a_block {
            text-align: left;
            padding: 0.5rem 0 0.25rem;
            color: #000000;
            font-size: 0.75rem;
            font-weight: bold;
            text-align: center;
        }
        .emptyBlock {
            padding-top: 70%;
            color: #000000;
            text-align: center;
            font-size: 0.65rem;
        }
        .b_block {
            color: #2b2b2b;
            font-size: 0.5rem;
            .service {
                font-size: 0.6rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 1.4rem;
                padding: 0 0.4rem;
                .iconser {
                    background: url(../../../assets/wap/images/login/icon_customer_default.png)
                        no-repeat center;
                    background-size: contain;
                    display: inline-block;
                    width: 0.9rem;
                    height: 0.7rem;
                    vertical-align: middle;
                }
            }
            .top {
                height: 2rem;
                background: #f5f5f5;
                display: flex;
                align-items: center; /*垂直居中*/
                justify-content: center; /*水平居中*/
                color: #9e9e9e;
                dd {
                    flex: 1;
                }
                .left {
                    text-align: left;
                    padding-left: 0.65rem;
                }
                .right {
                    text-align: right;
                    padding-right: 0.65rem;
                }
            }
            ul {
                padding: 0.1rem 0 0.25rem 0;
                li {
                    position: relative;
                    padding: 0.4rem 0.4rem 0;
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
                    .billLeft {
                        padding-right: 0.4rem;
                        .iconfont {
                            color: #ed171f;
                            font-size: 1.1rem;
                            // transform: translate(12%, 8%);
                            &.pay {
                                color: #0d9d94;
                            }
                            &.get {
                                color: #ed171f;
                            }
                        }
                    }
                    .billRight {
                        flex: 1;
                        &::before {
                            content: "";
                            height: 1px;
                            width: 88%;
                            background: #f0f0f0;
                            position: absolute;
                            bottom: 0;
                            left: 12%;
                        }
                        .billUp {
                            p {
                                font-size: 0.65rem;
                                // font-weight: bold;
                            }
                        }
                        .billDown {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-end;
                            em {
                                font-style: normal;
                                color: #858585;
                                padding-bottom: 0.1rem;
                            }
                            span {
                                font-size: 0.6rem;
                                &.less {
                                    color: #000;
                                }
                                &.add {
                                    color: #ea531a;
                                }
                            }
                        }
                    }
                }
            }
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
//     border-bottom: 1px solid #fac307;

//     li.leftSide {
//         flex: 1;
//         .icon-back-arrow {
//             color: #ffc001;
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

