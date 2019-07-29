<template>
    <f7-navbar class='Commonnavbar'>
        <ul class="searchBox">
            <li class="leftSide" @click="jumpLink('/CN/Login')">
                 <i class="icon iconfont icon-back-arrow"></i>
            </li>
            <li class="rightSide" @click="jumpLink('/Member/SearchNews')">
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
    props: ["title"],
    data() {
        return {
            iconMenu: buildImg(require("@/assets/wap/images/home/navbar/iconMenu.png")),

        };
    },
    computed: {
        ...mapGetters(["UserInfo", "GetUserCount", "GetCurrentActiveUserCount"]),
    },
    methods: {
        jumpLink(url){
                 window.jumpLink(url,'_router')
        }
    }
};
</script>


<style lang="scss" scoped>
@import "../../../style/mixin";
.searchBox{
    background: #ffc004;
    display: flex;
    width: 100%;
    align-items:center;
    justify-content:center;
    li.leftSide{
        flex: 1;
    }
    li.rightSide{
        flex: 12;
        position: relative;
        input{
            width: 92%;
            display: block;
            height: 42px;
            color: #696969;
            border: 1px solid #ffffff;
            background:none;
            outline:none;
            border-radius: 42px;
            margin: 0 auto;
            text-align: center;
            line-height: 42px;
            font-size: 0.6rem;
            background: #ffffff;
            
        }
        .icon-search{
            position:absolute;
            left: 20%;
            top: 4px;
            color: #cfcfcf;
            font-size: 1rem;
        }
    }
    
}
.icon-note{
    color: #ffffff;
    font-size: 1.25rem;
}
</style>

