<template>
    <f7-navbar class='navbar'>
        <ul class="searchBox">
            <li class="leftSide">
                <i class="icon iconfont icon-note"></i>
            </li>
            <li class="rightSide" @click="jumpLink">
                <i class="icon iconfont icon-search"></i>
                <input type="text" v-model="searchValue" placeholder="搜索您感兴趣的问题" >
                <i class="icon iconfont icon-guanbi1" v-if="searchValue!=''" @click="searchValue=''"></i>
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
            searchValue:""

        };
    },
    components: {},
    computed: {
        ...mapGetters(["UserInfo", "GetUserCount", "GetCurrentActiveUserCount"]),
    },
    methods: {
        jumpLink(){
                 window.jumpLink("/Member/SearchNews",'_router')
        }
    }
};
</script>


<style lang="scss" scoped>
@import "../../../style/mixin";
.searchBox{
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
            left: 10%;
            top: 4px;
            color: #cfcfcf;
            font-size: 1rem;
        }
        .icon-guanbi1{
            position:absolute;
            right: 8%;
            top: 10px;
            color: #cfcfcf;
            font-size: 0.75rem;
        }
    }
}
.icon-note{
    color: #ffffff;
    font-size: 1.25rem;
}
</style>
