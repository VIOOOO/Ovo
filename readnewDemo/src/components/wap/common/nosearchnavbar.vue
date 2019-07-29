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
        backEvent() {
            if(this.back!="AnimationBack"){
                window.jumpLink(this.back, '_router')
            }else{
                this.$f7.view.main.router.back();
            }
            
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
    border-bottom: 1px solid #f5f5f5;
    box-sizing: border-box;
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
