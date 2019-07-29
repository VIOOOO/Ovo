<template>
    <f7-page class="newsDetail">
        <!-- <navbar title="新闻详情" back="/Home"></navbar> -->
        <div class="p_header">
            <div class='Commonnavbar'>
                <ul class="searchBox">
                    <li class="leftSide" @click="isModalClose">
                        <i class="icon iconfont icon-back-arrow"></i>
                    </li>
                    <li class="rightSide">
                        新闻详情
                    </li>
                </ul>
            </div>
        </div>
        <div class="mainContent">
            <h1 v-if="NewsDetail.Data&&NewsDetail.Data.TitleHtml" v-html="NewsDetail.Data.TitleHtml"></h1>
            <div v-if="NewsDetail.Data&&NewsDetail.Data.Content" v-html="NewsDetail.Data.Content"></div>
        </div>
        <!-- <toolbar></toolbar> -->
    </f7-page>
</template>
<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import navbar from "@/components/wap/common/nosearchnavbar";
import toolbar from "@/components/wap/common/toolbar";
import { buildImg, getNowFormatDate, jumpLinUrl, clearUser } from "@/config/env";
import mySwipers from "../../../../static/plugin/swiper.min.js";
import "../../../../static/plugin/swiper.min.css";
import PullTo from 'vue-pull-to'

export default {
    props: ["NewShow"],
    data() {
        return {
            NewsDetail: {},
        };
    },
    created() {
        // if (this.$f7Route.params && this.$f7Route.params.NewId != null) {
        //     this.NewId = this.$f7Route.params.NewId
        //     this.GetNewsDetailEvent();
        // }

    },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    watch: {
        NewShow(NewVal, OldVal) {
            if (NewVal != OldVal) {
                this.NewsDetail = {};
                this.GetNewsDetailEvent();
            }
        }
    },
    methods: {
        async GetNewsDetailEvent() {
            let resault = await this.$store.dispatch("GetNewsDetail", { id: this.NewShow });
            this.NewsDetail = resault
        },
        isModalClose() {
            this.$emit("$_isModelClose");
        }
    },
    components: {
        navbar,
        toolbar,
    },
    mounted() {

    }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.mainContent {
    padding: 0.75rem 0.35rem 15% 0.35rem;
    font-size: 0.6rem;
    height: 100%;
    overflow-y: scroll;
    margin-bottom: -48px;
}
// 搜索栏

.searchBox {
    background: #ffffff;
    display: flex;
    width: 100%;
    height: 48px;
    align-items: center;
    justify-content: center;
    //   border-bottom: 1px solid #fac307;
    li.leftSide {
        flex: 1;
        .icon-back-arrow {
            color: #333;
            font-size: 1.35rem;
        }
    }
    li.rightSide {
        flex: 20;
        position: relative;
        color: #030303;
        text-align: center;
        text-indent: -15%;
        font-size: 0.7rem;
        font-weight: bold;
    }
}
</style>
<style>
.mainContent p {
    color: #333;
    padding: 12px 0;
}
.mainContent h1 {
    font-size: 20px;
    font-weight: bold;
}
img {
    width: 100%;
}
figure {
    padding: 0;
    margin: 0;
}
.article-src-time {
    font-size: 0.5rem;
    padding-top: 0.35rem;
    color: #9f9f9f;
    font-weight: normal;
}
</style>





