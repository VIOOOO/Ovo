<template>
    <f7-subnavbar class="subNavbar" sliding>
        <f7-link class="leftBlock" :href="href || preUrl">
            <img  v-if="href!==''" :src="iconLeftArrow" alt="">
        </f7-link>
        <div v-if="title" class="sub-title">
            <!-- <img class="s-image" v-if="image" :src="image" /> -->
            {{title}}
        </div>
        <f7-link class="rightBlock" href="javascript:;"></f7-link>
    </f7-subnavbar>
</template>

<script>
import { buildImg } from "@/config/env";
export default {
    data() {
        return {

        };
    },
    created() {
        setTimeout(() => {
            this.preUrl = this.$f7Router.previousRoute.url == '/Home' ? '/' : this.$f7Router.previousRoute.url;
        }, 0);
    }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.subNavbar {
    background-color: $gold_navajo;
    height: 1.35rem;
    padding-top: 0;
    .leftBlock,
    .rightBlock {
        width: 3rem;
        box-sizing: border-box;
        padding-left: 0.3rem;
        img {
            width: 0.9rem;
            max-height: 1.3rem;
        }
    }
    .sub-title {
        @include sc(0.8rem, #65450c);
        // font-family: Microsoft YaHei;
        font-weight: bold;
        text-align: center;
        width: 100%;
        height: 100%;
        line-height: 1.35rem;

        // .s-image {
        //     height: 1.2rem;
        //     position: relative;
        //     top: -0.05rem;
        //     vertical-align: middle;
        // }
    }
    .home {
        opacity: 0.7;
    }
}
</style>


