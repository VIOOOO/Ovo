<template>
    <f7-page class="panelLeft">
        <div class="pLTitle">
            <div class="pLtitleIcon">
                <img :src="logoIcon" alt="">
            </div>
        </div>
        <f7-list class="pLMenuList">
            <f7-list-item v-for="(item,index) in menuList" :key="index" class="icon-fun-left" :media="item.icon" :link="item.href" @click="$_eventClick(item)" :title="item.text" view="#main-view" panel-close></f7-list-item>
        </f7-list>
        <!-- <p class="version">V:1.11.39</p> -->
    </f7-page>
</template>
<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import { buildImg, clearUser, cookie } from "@/config/env";
export default {
    data() {

        const menuList = [
            {
                icon: buildImg(
                    require("../../../assets/wap/images/common/panelLeft/iconKernel.png")
                ),
                text: "代理中心",
                href: "/Member/Home"
            },
        ];
        return {
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            menuList
        };
    },
    computed: {
        // ...mapGetters(["clientContact"]),
    },
    methods: {
        $_eventClick(item) {
            const that = this;
            if (item.text == "安全退出") {
                // 清理用户信息
                clearUser()
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: `您已安全退出会员账号，非常感谢！`,
                    ok: true,
                    oktext: "确定",
                    close: false,
                    success: () => {
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: false,
                            // close: true,
                        })
                        window.jumpLink('/CN/Login', '_router');
                    },
                })
                // const loginData = cookie.getJSON('UserLogin');
                // console.log(loginData)
            }
        }
    }
};
</script>


<style lang="scss" scoped>
@import "../../../style/mixin";
.panelLeft {
    .pLTitle {
        background: url(../../../assets/wap/images/common/panelLeft/panelLeftBg01.jpg)
            no-repeat;
        background-size: cover;
        height: 5.1rem;
        .pLtitleIcon {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            > img {
                width: 3.6rem;
            }
        }
    }
    .pLMenuList {
        background: url(../../../assets/wap/images/common/panelLeft/panelLeftBg02.jpg)
            no-repeat;
        background-size: contain;
        padding: 2.6rem 2.09rem 1rem;
        .icon-fun-left {
            padding-bottom: 0.4rem;
        }
    }
}
</style>
<style>
.pLMenuList .icon-fun-left img {
    width: 0.9rem;
}

.pLMenuList .icon-fun-left .item-title {
    font-size: 0.58rem;
}
.panelLeft .pLMenuList .icon-fun-left .item-inner {
    background-image: none;
    min-height: 1rem;
    padding-right: 0;
    margin-left: 0.3rem;
}
.panelLeft .pLMenuList .icon-fun-left .item-inner::after {
    background: #333333;
    height: 1px;
    top: 88%;
}
.panelLeft .pLMenuList .icon-fun-left .item-inner .item-title {
    padding: 0 0.1rem;
}
</style>

