<template>
    <div v-if="LoaderPre" :class="['loaderPre',{'bgColor':bgBlack}]">
        <!-- wap 部分 loading this.$store.dispatch("LoaderPre", true);-->
        <div v-if="LoaderPre" class="lpBlock">
            <f7-preloader size="44px" color="#000"></f7-preloader>
        </div>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
    props: ["bgBlack"],
    computed: mapGetters(["LoaderPre"])
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.loaderPre {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: $zindex_large;
    &.bgColor {
        background-color: $backdrop_hyaline;
        .lpBlock {
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0px 0px 4px 0px #5a5a5a;
        }
    }
    .lpBlock {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -60%);
        padding: 0.4rem;
        border-radius: 0.5rem;
        z-index: $zindex_top;
    }
}
</style>


