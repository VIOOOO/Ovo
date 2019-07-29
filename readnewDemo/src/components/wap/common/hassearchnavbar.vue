<template>
    <f7-navbar class='navbar'>
        <ul class="searchBox">
            <li class="rightSide" @click="backEvent">
                <i class="icon iconfont icon-back-arrow"></i>
                {{title}}
            </li>
        </ul>
    </f7-navbar>
</template>

<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import { buildImg } from "@/config/env";
export default {
    props:{
        title:"",
        back:""
    },
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
        backEvent() {
            window.jumpLink('/Home', '_router')
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
    height: 50px;
    line-height: 50px;
    border-bottom: 1px solid red;
    li.rightSide {
        flex: 1;
        position: relative;
        text-align: center;
        
        .icon-search {
            position: absolute;
            left: 7%;
            top: 2px;
            color: #cfcfcf;
            font-size: 22px;
        }
        .icon-back-arrow{
            position: absolute;
            top: 0;
            left: 0;
            font-size: 28px;
        }
    }
}

</style>
