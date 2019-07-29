<template>
    <f7-page class="HomePage">
        <navbar title="邀请好友" back="/Home"></navbar>
        <section class='enliven'>
            <div class="content">
                <div>
                    <img :src="top" alt="">
                </div>
                <div class="invitationBlock">
                    <div class="invRule">
                        <div class="irTile">邀请方式：</div>
                        <div class="irRuleList" @click="isModalStatusRight=true">查看规则 ></div>
                    </div>
                    <ul class="imglist copy" :data-clipboard-text="shareUrl" @click="clipboard('您已复制分享链接,可进行分享')">
                        <li>
                            <img :src="img1" alt="">
                            <p>微信好友</p>
                        </li>
                        <li>
                            <img :src="img2" alt="">
                            <p>朋友圈</p>
                        </li>
                        <li>
                            <img :src="img3" alt="">
                            <p>QQ好友</p>
                        </li>
                        <li>
                            <img :src="img4" alt="">
                            <p>QQ空间</p>
                        </li>
                    </ul>
                    <div class="MineRule">
                        <div class="openPop" @click="isModalStatusLeft=true">我的邀请</div>
                    </div>
                    <div v-if="UserInfo">
                        <div class="shareContent">
                            <textarea v-model="shareUrl"></textarea>
                        </div>
                        <div class="shareMyLink copy" :data-clipboard-text="shareUrl" @click="clipboard('您已复制分享链接,可进行分享')">
                            <p>点击复制我的分享链接</p>
                        </div>
                    </div>
                </div>
                <!-- <div class="MineRule">
                    <div>
                        <a href="javascript:;" class="open-popup" @click="isModalStatusLeft=true">我的邀请</a>
                    </div>
                    <div>
                        <a href="javascript:;" class="open-popup" @click="isModalStatusRight=true">查看规则</a>
                    </div>
                </div> -->

                <div class="sucrateBlock">
                    <ul class="sucrate">
                        <li class="sucTitle">如何提升邀请成功率</li>
                        <li class="sucrul">1.邀请您的家人、朋友、同学成功率最好。</li>
                        <li class="sucrul">2.同时分享到3个人以上微信/QQ群，成功率提升200%以上。</li>
                        <li class="sucrul">3.可以告诉你的朋友：在注册登录后才可以收到奖励，并可以提现。</li>
                    </ul>
                    <!-- <img :src="bottom" alt=""> -->
                </div>
            </div>
        </section>
        <f7-popup :opened="isModalStatusLeft" theme="black">
            <div class="p_header">
                <div class='Commonnavbar'>
                    <ul class="searchBox" @click="isModalStatusLeft=false">
                        <li class="leftSide">
                            <i class="icon iconfont icon-back-arrow"></i>
                        </li>
                        <li class="rightSide">
                            我的邀请
                        </li>
                    </ul>
                </div>
            </div>
            <div class="p_content">
                <div class="topBgbanner">
                    <div class="allmoney">
                        <p>{{GetMyInviteInfo.TotalBalance?GetMyInviteInfo.TotalBalance:0}}</p>
                        <h3>邀请好友所获得的收益累计</h3>
                    </div>
                    <div class="shareleft">
                        <p>{{GetMyInviteInfo.TodayInvite?GetMyInviteInfo.TodayInvite:0}}</p>
                        <h3>今日邀请人数</h3>
                    </div>
                    <div class="shareright">
                        <p>{{GetMyInviteInfo.TotalInvite?GetMyInviteInfo.TotalInvite:0}}</p>
                        <h3>总邀请人数</h3>
                    </div>
                </div>
                <div>
                    <ul class="toplist add">
                        <li>昵称</li>
                        <li>邀请好友</li>
                        <li>时间</li>
                    </ul>
                </div>
                <div class="toplistBlock" v-if="GetMyInviteInfo">
                    <ul class="toplist list" v-for="(itme,index) in GetMyInviteInfo.UserList" :key="index">
                        <li>{{itme.UserName.substring(0,4)}}***{{itme.UserName.substr(itme.UserName.length-3)}}</li>
                        <li>{{itme.UserName.substring(0,4)}}***{{itme.UserName.substr(itme.UserName.length-3)}}</li>
                        <li>{{new Date(itme.CreateTime).getFullYear()}}.{{new Date(itme.CreateTime).getMonth()+1}}.{{new Date(itme.CreateTime).getDate()}}</li>
                    </ul>
                </div>
                <div v-else>
                    <ul class="toplist empty">
                        暂时没有邀请好友
                    </ul>
                </div>
                <div v-if="!UserInfo">
                    <ul class="toplist empty">
                        您尚未登录
                    </ul>
                </div>

            </div>
        </f7-popup>
        <f7-popup :opened="isModalStatusRight" class="invitationRulePop" theme="black">
            <div class="p_header">
                <div class='Commonnavbar'>
                    <ul class="searchBox" @click="isModalStatusRight=false">
                        <li class="leftSide">
                            <i class="icon iconfont icon-back-arrow"></i>
                        </li>
                        <li class="rightSide">
                            查看规则
                        </li>
                    </ul>
                    <div class="invitationRule">
                        <div class="invRuleTilet">
                            <img :src="rules02" alt="">
                        </div>
                        <!-- <div class="invRuleSub">
                            <img :src="rules02" alt="">
                        </div>
                         <ul class="invRuleList">
                            <li class="iRList" v-for="(irItem,irInd) in invrule" :key="irInd">
                                <div>{{irItem.suba}}</div>
                                <div>
                                    <img :src="rules03" alt="">
                                    奖励
                                    <span>【 {{irItem.subb}}元 】</span>
                                </div>
                            </li>
                        </ul> -->
                    </div>
                </div>
            </div>
        </f7-popup>
        <toolbar></toolbar>
    </f7-page>
</template>
<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import navbar from "@/components/wap/common/nosearchnavbar";
import toolbar from "@/components/wap/common/toolbar";
import { buildImg, getNowFormatDate, clearUser } from "@/config/env";
import Clipboard from "clipboard";
export default {
    data() {
        const invrule = [
            {
                suba: "好友注册",
                subb: "2.0"
            },
            {
                suba: "第一天",
                subb: "1.0"
            },
            {
                suba: "第二天",
                subb: "1.0"
            },
            {
                suba: "第三天",
                subb: "1.0"
            },
            {
                suba: "第四天",
                subb: "1.0"
            },
            {
                suba: "第五天",
                subb: "1.0"
            },
            {
                suba: "第六天",
                subb: "1.0"
            }
        ];
        return {
            invrule,
            top: buildImg(require("@/assets/wap/images/news/top.jpg")),
            img1: buildImg(require("@/assets/wap/images/news/wechatinvite.png")),
            img2: buildImg(require("@/assets/wap/images/news/wechatgrupinvite.png")),
            img3: buildImg(require("@/assets/wap/images/news/qqinvite.png")),
            img4: buildImg(require("@/assets/wap/images/news/qzone.png")),
            rules02: buildImg(require("@/assets/wap/images/news/rules02.png")),
            isModalStatusLeft: false,
            isModalStatusRight: false,
            GetMyInviteInfo: {
                TotalBalance: 0,
                TodayInvite: 0,
                TotalInvite: 0,
                UserList: []
            }

        }
    },
    created() {
        if (this.UserInfo) {
            this.GetMyInvite()
        }

    },
    computed: {
        ...mapGetters(["UserInfo"]),
        shareUrl() {
            if (this.UserInfo) {
                return `来自【天宇头条】的分享:邀请赚取奖金，新注册用户领现金红包 http://www.ybao800.com?inviteCode=${this.UserInfo.InvitationCode ? this.UserInfo.InvitationCode : ""}`;
            } else {
                return ""
            }
        },
    },
    watch: {

    },
    methods: {
        jumpLink() {

            if ($local.vm.$f7.view.main.router.history[$local.vm.$f7.view.main.router.history.length - 2] == "/Member/MyCenter") {
                // window.jumpLink(url, "_router");
                this.$f7.router.navigate("/Member/MyCenter");
            } else {
                this.$f7.router.navigate("/Member/Home");
            }

        },
        clipboard(text) {
            if (this.UserInfo) {
                this.$f7.notification.create(
                    {
                        title: text,
                        closeButton: true,
                        closeTimeout: 3000
                    }
                ).open();
            } else {
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "提示",
                    content: "请登录后再邀请您的好友"
                });
            }

        },
        async GetMyInvite() {
            let ResualtData = await this.$store.dispatch('GetMyInvite');
            if (ResualtData.StatusCode == "0") {
                this.GetMyInviteInfo = ResualtData.Data
            } else {
                if (ResualtData.Message == "未登录") {
                    clearUser();
                }
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "提示",
                    content: ResualtData.Message
                });
                return
            }
        },
    },
    components: {
        navbar,
        toolbar,
    },
    mounted() {
        new Clipboard(".copy");


    },
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.HomePage {
    .enliven {
        background-color: #ffffff;
        padding-bottom: 3rem;
        min-height: 100%;
        img {
            width: 100%;
        }
        .invitationBlock,
        .sucrateBlock {
            margin: 0.4rem 0.3rem;
            border-radius: 8px;
            box-shadow: 0 0 8px #dadada;
        }
        .invitationBlock {
            padding: 0.5rem;
            .invRule {
                display: flex;
                justify-content: space-between;
                align-items: center;
                .irTile {
                    font-size: 0.65rem;
                    font-weight: bold;
                }
                .irRuleList {
                    font-size: 0.53rem;
                }
            }
            .imglist {
                width: 100%;
                padding: 1rem 0;
                overflow: hidden;
                li {
                    width: 25%;
                    float: left;
                    margin-bottom: 0.55rem;
                    text-align: center;
                    img {
                        width: 62%;
                    }
                }
            }
            .MineRule {
                .openPop {
                    background: #ed1721;
                    width: 4.8rem;
                    height: 1.7rem;
                    line-height: 1.7rem;
                    margin: 0 auto;
                    text-align: center;
                    border-radius: 10px;
                    color: #fff;
                }
            }
            .shareContent {
                color: red;
                width: 100%;
                padding: 0.5rem 0 0.2rem;
                display: block;
                textarea {
                    display: block;
                    font-size: 0.55rem;
                    line-height: 0.8rem;
                    width: 100%;
                }
            }
            .shareMyLink {
                font-size: 0.7rem;
                text-align: center;
                padding: 0.2rem 0;
            }
        }
        .sucrateBlock {
            padding: 0.4rem 0.8rem 0.8rem;
            .sucrate {
                .sucTitle {
                    background: url(../../../assets/wap/images/news/sucrate01.png)
                        no-repeat center center;
                    background-size: 80% auto;
                    font-size: 0.8rem;
                    font-weight: bold;
                    padding: 0.3rem 0;
                    text-align: center;
                }
                .sucrul {
                    color: #666;
                    line-height: 1rem;
                }
            }
        }
    }
}
// 搜索栏

.searchBox {
    background: #ffffff;
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: center;
    //   border-bottom: 1px solid #fac307;
    li.leftSide {
        flex: 1;
        .icon-back-arrow {
            color: #333;
            font-size: 1.35rem;
        }
    }
    li.rightSide {
        flex: 20;
        position: relative;
        color: #030303;
        text-align: center;
        text-indent: -15%;
        font-size: 0.7rem;
        font-weight: bold;
    }
}
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
// 我的邀请弹窗
.p_content {
    overflow: scroll;
    background: #f5f5f5;
    height: 100%;

    .topBgbanner {
        background: url(../../../assets/wap/images/share/topBgbanner.png)
            no-repeat center center;
        background-size: 96% auto;
        position: relative;
        padding: 1.3rem;
        color: #ffb589;
        text-align: center;
        p {
            color: #fff;
        }
        h3 {
            font-size: 0.55rem;
            font-weight: normal;
        }
        .allmoney {
            padding-bottom: 0.6rem;
            > p {
                font-size: 1.4rem;
            }
        }
        .shareleft,
        .shareright {
            display: inline-block;
            width: 48%;
            > p {
                font-size: 0.8rem;
            }
        }
        img {
            width: 100%;
        }
    }
    .toplistBlock {
        padding-bottom: 2rem;
    }
    .toplist {
        display: flex;
        &.add {
            background: #e5e4e4;
            padding: 0.35rem 0 0.5rem;
        }
        &.empty {
            text-align: center;
            display: block;
            padding-top: 3.5rem;
        }
        &.list {
            line-height: 1.25rem;
            li {
                font-size: 0.6rem;
                &:nth-child(2),
                &:nth-child(3) {
                    color: #666;
                }
            }
        }

        li {
            flex: 1;
            text-align: center;
        }
    }
}
// 查看规则弹窗
.invitationRulePop {
    background: url(../../../assets/wap/images/news/rules01.jpg) no-repeat
        center top;
    background-size: 100% 100%;
}
.invitationRule {
    .invRuleTilet {
        text-align: center;
        padding-top: 2rem;
        > img {
            width: 9rem;
        }
    }
    .invRuleSub {
        text-align: center;
        padding: 0.8rem 0;
        > img {
            width: 8rem;
        }
    }
    .invRuleList {
        padding: 0 1rem;
        .iRList {
            font-size: 0.65rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 1.8rem;
            border-bottom: 1px solid #e6e6e6;
            &:last-child {
                border: none;
            }
            div {
                &:nth-child(2) {
                    > img {
                        width: 0.45rem;
                        vertical-align: middle;
                    }
                    > span {
                        color: #ed171f;
                    }
                }
            }
        }
    }
}
.p_footer {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
}
</style>



