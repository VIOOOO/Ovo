<template>
    <f7-page id="a_head_top">
        <navbar slot="fixed"></navbar>
        <!--banner-->
        <!-- <banner></banner> -->
        <!-- 返回顶部 -->
        <!-- <setTop></setTop> -->
        <!-- 滑到底部提示 -->
        <!-- <bottomHint></bottomHint> -->
        <toolbar slot="fixed"></toolbar>
    </f7-page>
</template>
<script>
import navbar from "@/components/wap/common/navbar";
import toolbar from "@/components/wap/common/toolbar";
// import banner from "@/components/wap/home/banner";
// import setTop from "@/components/wap/common/setTop";
import bottomHint from "@/components/wap/common/bottomHint";

import { buildImg } from "@/config/env";
import TYPES from "@/store/mutation-types";
import { mapGetters, mapActions } from "vuex";
import wsCache from "web-storage-cache";
let cache = new wsCache();
export default {
    components: {
        navbar,
        toolbar,
        // banner,
        // setTop,
        bottomHint
    },
    data() {

        return {
            gameCat: "hotGames",
        };
    },
    created() {
        const that = this;

    },
    computed: {
        ...mapGetters(["UserInfo"]),
    },
    methods: {
    }
};
</script>

<style lang="scss" scoped>
@import "../../style/mixin";
// .announce{
//     padding: 0.25rem 0.5rem;
// }
#a_head_top {
    background-color: $gray_little;
    .my-row {
        margin: 0.4rem 0 0 0;
    }
    .bottomHint {
        background-color: $white;
    }
}
</style>

