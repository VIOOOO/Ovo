<template>
    <f7-page class="HomePage">
        <navbar title="新闻详情" back="/Home"></navbar>
        
        <div class="mainContent" >
        <h1 v-if="NewsDetail.Data&&NewsDetail.Data.TitleHtml" v-html="NewsDetail.Data.TitleHtml"></h1>
        <div v-if="NewsDetail.Data&&NewsDetail.Data.Content" v-html="NewsDetail.Data.Content"></div>
        </div>
        <toolbar></toolbar>
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
    data() {
        return {
            NewsDetail:{},
            NewId: "",


        };
    },
    created() {
        // debugger
        if (this.$f7Route.params && this.$f7Route.params.NewId != null) {
            this.NewId = this.$f7Route.params.NewId
            this.GetNewsDetailEvent();
        }
        
    },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    watch: {},
    methods: {
       async GetNewsDetailEvent(){
            let resault= await  this.$store.dispatch("GetNewsDetail",{id:this.NewId});
            this.NewsDetail=resault
        },
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
    
    
}


</style>
<style>
.mainContent p{
    color: #333;
    padding: 12px 0;
    font-size: 0.55rem;
}
.mainContent h1{
    font-size: 20px;
    font-weight: bold;
}
img{
        width: 100%;
}
figure{
    padding: 0;
    margin: 0;
}
.article-src-time{
    font-size: 0.5rem;
    padding-top: 0.35rem;
    color: #9f9f9f;
    font-weight: normal;
}
</style>





