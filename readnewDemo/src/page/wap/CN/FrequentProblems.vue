<template>
    <f7-page class="frequentProblemsPages">
        <navbar title="常见问题" back="/Member/MyCenter"></navbar>
        <div class="section">
            <ul class="faq">
                <li v-for="(fItem ,find) in faqList" :key="find">
                    <div class="faqTitle">{{fItem.tit}}</div>
                    <div class="faqExplain">{{fItem.exp}}</div>
                    <div class="faqExplain" v-if="fItem.expsub">{{fItem.expsub}}</div>
                </li>
            </ul>

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
        const faqList = [
            {
                tit: "天宇头条是什么？",
                exp: "天宇头条是一款移动端资讯阅读软件。用户可以通过阅读、签到、邀请好友、做任务等方式赚取金币兑换现金或商品。",
                expsub: ""
            },
            {
                tit: "天宇头条为什么会给用户现金奖励？",
                exp: "为题引领全民阅读，帮助大家养成良好的阅读习惯，在阅读文章的过程中，天宇头条将给予一定的现金奖励！让您在阅读过程中不仅增长见识，而且还能有所收益！",
                expsub: ""
            },
            {
                tit: "邀请好友有什么好处？",
                exp: "邀请好友能让你的现金收益迅速增加。现在每邀请一位有效好友可获得至少5元现金奖励，你的好友越多，收益越大。",
                expsub: ""
            },
            {
                tit: "分享出去的二维码打不开怎么办？",
                exp: '方法1：告诉朋友到手机应用商店，搜索"天宇头条"下载安装，注册登陆后到右下角"我的"界面找到"输入邀请码"一栏，填写您的邀请码完成绑定 ',
                expsub: '方法2：重新分享一次二维码给朋友，最新的可正常打开 （如果多次尝试失败，可点击"我的"找到"联系客服"获得帮助）'
            },
            {
                tit: '邀请好友的提成收益有上限吗？',
                exp: '没有上限，邀请好友越多收益越多。',
                expsub: ''
            },
            {
                tit: '为什么有的好友是无效邀请？',
                exp: '作弊行为的好友（包括但不限于同一设备注册登录多个账号、虚拟器、脚本等非正常方式进行恶意刷注册、金币或阅读时长），系统会冻结该好友账号并在您的好友列表中显示无效邀请，无效好友将不会再产生进贡奖励。扣除违规注册好友提供的收益后，您即可正常兑换，不用担心。',
                expsub: ''
            },
            {
                tit: '如何兑换？',
                exp: '金币到达提现额度后，您可以在"我的"->"提现兑换"选择"支付宝"或"微信"或"话费"进行现金提现或兑换商品。（请确认后选择，一旦兑换将无法撤回）',
                expsub: ''
            },
            {
                tit: '提现多久到账？',
                exp: '提现申请提交后，正常情况下会在3个工作日内到账（节假日顺延）；有风险的账户会交由人工审核。审核通过后，会在3~5个工作日内到账（节假日顺延），请耐心等待，提现也许会晚到但绝不会缺席。审核未通过的则显示订单关闭',
                expsub: ''
            },
            {
                tit: '如何更改绑定/注册手机号？',
                exp: '天宇条账号是不能换绑手机号的哦，每个手机号只能注册一个天宇头条账号，如果您的手机号已经注册，讲无法进行再次注册',
                expsub: ''
            }

        ]
        return {
            faqList,
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            loginIcon01: buildImg(
                require("@/assets/wap/images/Login/loginIcon01.png")
            ),
            loginIcon02: buildImg(
                require("@/assets/wap/images/Login/loginIcon02.png")
            )
        };
    },
    created() { },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    components: { navbar },
    methods: {
        jumpLink(url) {
            window.jumpLink(url, "_router");
        }
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.frequentProblemsPages {
    // background: #f5f5f5;
    .section {
        padding: 0.3rem 0.6rem 4rem;
        width: 100%;
        .faq {
            > li {
                .faqTitle {
                    font-size: 0.75rem;
                    font-weight: bold;
                    color: #2b2b2b;
                    padding: 0.6rem 0 0.2rem;
                }
                .faqExplain {
                    color: #666;
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
</style>


