<template>
    <div v-if="LoaderPage" :class="['loaderPage',{'bgColor':bgBlack}]">
        <!-- wap 全屏 loading this.$store.dispatch("LoaderPage", true);-->
        <div class="lpBlock">
            <f7-preloader size="44px"></f7-preloader>
        </div>

    </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
    props: ["bgBlack"],
    computed: mapGetters(["LoaderPage"])
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.loaderPage {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: $zindex_high;
    &.bgColor {
        background-color: $backdrop_hyaline4;
    }
    .lpBlock {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-45%, -70%);
        padding: 0.4rem;
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 0.5rem;
        box-shadow: 0px 0px 4px 0px #5a5a5a;
        z-index: $zindex_top;
    }
}
</style>


