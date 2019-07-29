<template>
    <div id="container">
        <div id="left" class="column aside">
            <p>Sidebar</p>
        </div>
        <div id="content" class="column section">
            <p>Main content</p>
        </div>
    </div>
</template>

<script>
import { buildImg, formatMoney } from "@/config/env";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";

export default {
    components: {
    },
    data() {

        return {

        };
    },
    methods: {},
    created() {

    },
    computed: {

    }
};
</script>

<style lang="scss" scoped>
@import "../../style/mixin";
#container {
    overflow: hidden;
    width: 100%;
}
.column {
    background: #ccc;
    float: left;
    width: 200px;
    min-height: 100%;
    margin-right: 5px;
    margin-bottom: -99999px;
    padding-bottom: 99999px;
}
#content {
    background: #eee;
}
</style>
