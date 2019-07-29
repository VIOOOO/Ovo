<template>
    <f7-page class="billingRecord">
        <navbar title="账单记录" back="/Member/MyCenter"></navbar>
        <div class="billingRecordBlock">
            <div class="b_block" v-if="listResult">
                <div>
                    <!-- type:3 取款； -->
                    <ul v-for="(item,index) in listResult" :key="index">
                        <li v-show="item.Type==3">
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
                                    <span class="less">-{{item.Balance}}</span>
                                </div>
                            </div>
                        </li>
                        <li v-show="item.Type==4||item.Type==1||item.Type==0">
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
                                    <span class="add">+{{item.Balance}}</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="emptyBlock" v-else>
                暂无相关记录呦!
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
            this.$store.dispatch("LoaderPage", true);
            let ResualtData = await this.$store.dispatch('UserBalanceChanges');
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
.billingRecord {
    .billingRecordBlock {
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
                                font-weight: bold;
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
                                font-size: 0.9rem;
                                &.less {
                                    color: #0db211;
                                }
                                &.add {
                                    color: #ed171f;
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


