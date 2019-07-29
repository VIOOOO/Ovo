<template>
    <f7-navbar class='navbar'>
        <ul class="searchBox">
            <li class="leftSide" @click="jumpLink">
                <i class="icon iconfont icon-note"></i>
            </li>
            <li class="rightSide" @click="jumpLinks">
                <i class="icon iconfont icon-search"></i>
                <input type="text" placeholder="搜索你感兴趣的问题" disabled>
            </li>
        </ul>
    </f7-navbar>
</template>

<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import { buildImg } from "@/config/env";
export default {
    data() {
        return {
            iconMenu: buildImg(require("@/assets/wap/images/home/navbar/iconMenu.png")),

        };
    },
    components: {},
    computed: {
        ...mapGetters(["UserInfo"]),
    },
    methods: {
        jumpLink(url) {
            if (this.UserInfo) {
                window.jumpLink('/Member/MyCenter', '_router')
            } else {
                window.jumpLink('/CN/Login', '_router')
            }

        },
        jumpLinks() {
            window.jumpLink('/Member/SearchNews', '_router')
        }

    }
};
</script>


<style lang="scss" scoped>
@import "../../../style/mixin";
.searchBox {
    background: #fff;
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: center;
    li.leftSide {
        flex: 1;
        text-align: center;
    }
    li.rightSide {
        flex: 12;
        position: relative;
        input {
            background: #f5f5f5;
            font-size: 16px;
            display: block;
            width: 94%;
            height: 40px;
            line-height: 40px;
            padding-left: 13%;
            margin: 0 auto;
            color: #696969;
            border: 1px solid #ffffff;
            outline: none;
            border-radius: 7px;

        }
        .icon-search {
            position: absolute;
            left: 7%;
            top: 6px;
            color: #cfcfcf;
            font-size: 24px;
        }
    }
}
.icon-note {
    color: #000;
    font-size: 24px;
    position: relative;
    left: 5px;
}
</style>
