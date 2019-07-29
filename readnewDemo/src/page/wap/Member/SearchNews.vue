<template>
    <f7-page class="HomePage searchNews">
        <f7-navbar class="navbar">
            <ul class="searchBox">
                <li class="leftSide" @click="jumpLinks('/Home')">
                    <i class="icon iconfont icon-back-arrow"></i>
                </li>
                <li class="rightSide">
                    <i class="icon iconfont icon-search"></i>
                    <input type="text" v-model="searchValue" placeholder="搜索你感兴趣的问题" @blur="filterData">
                    <i class="icon iconfont icon-guanbi1" v-if="searchValue!=''" @click="searchValue=''"></i>
                </li>
                <!-- <li class="SearchSide" @click="jumpLinks('/Home')">取消</li> -->
                <li class="SearchSide" @click="filterData">搜索</li>
            </ul>
        </f7-navbar>
        <section class="contentMainBox">
            <div class="searchDefaultBOX" v-if="showData">
                <h3>搜索感兴趣的内容</h3>
                <ul class="searchDefault">
                    <li>
                        <h3>
                            <img :src="img1" alt>
                        </h3>
                        <p>热点</p>
                    </li>
                    <li>
                        <h3>
                            <img :src="img2" alt>
                        </h3>
                        <p>文章</p>
                    </li>
                    <li>
                        <h3>
                            <img :src="img3" alt>
                        </h3>
                        <p>视频</p>
                    </li>
                </ul>
            </div>
            <div class="contentMain" v-else>
                <ul class="NewListBox" v-if="newlist">
                    <li v-for="(item,index) in newlist" :key="index">
                        <div class="NewList" v-touch:tap="$_handleClick(index,item.Id)" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                            <div class="leftSide">
                                <p>{{item.title}}</p>
                            </div>
                            <div class="rightSide" v-if="item.thumbnail_pic_s">
                                <img :src="item.thumbnail_pic_s" alt="">
                            </div>
                            <!-- <div class="lefticon">
                                <div>
                                    <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                    <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                            </div> -->
                            <!-- <div class="righticon" @click="del(item)"><i class="icon iconfont icon-X"></i></div> -->
                        </div>
                        <div class="NewListIMG" v-touch:tap="$_handleClick(index,item.Id)" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                            <h2 class="Title">{{item.title}}</h2>
                            <dl class="imageBox">
                                <dd v-if="item.thumbnail_pic_s">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </dd>
                                <dd v-if="item.thumbnail_pic_s02">
                                    <img :src="item.thumbnail_pic_s02" alt="">
                                </dd>
                                <dd v-if="item.thumbnail_pic_s03">
                                    <img :src="item.thumbnail_pic_s03" alt="">
                                </dd>
                            </dl>
                            <!-- <div class="shiwTime">
                                <div class="left">
                                    <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                    <span><i class="icon iconfont icon-zan"></i>
                                        <em>{{random(50,120)}}</em></span></div>
                                <div class="right" @click="del(item)"><i class="icon iconfont icon-X"></i></div>
                            </div> -->
                        </div>
                        <div class="newDel"><i v-on:click.stop="del(item)" class="icon iconfont icon-X"></i></div>
                    </li>
                </ul>
                <ul v-if="shownoresault" class="empty">
                    <li>
                        没有找到 "{{searchValue}}"匹配的内容
                    </li>
                </ul>
            </div>
        </section>
        <!-- 详细新闻弹窗 -->
        <f7-popup :opened="isModalNewsDetail" theme="black">
            <NewsDetail :NewShow="newName" @$_isModelClose="$_isModelClose"></NewsDetail>
        </f7-popup>
    </f7-page>
</template>
<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import SearchNavbar from "@/components/wap/common/SearchNavbar";
import toolbar from "@/components/wap/common/toolbar";
import { buildImg, getNowFormatDate, clearUser } from "@/config/env";
import mySwipers from "../../../../static/plugin/swiper.min.js";
import "../../../../static/plugin/swiper.min.css";
import NewsDetail from "@/page/wap/Member/NewsDetail";
export default {
    data() {
        return {
            isModalNewsDetail: false, // 新闻弹窗
            newName: "",
            showData: true,
            searchValue: "",
            mySwiper: false,
            swiperWidth: "",
            maxTranslate: "",
            maxWidth: "",
            img1: buildImg(require("@/assets/wap/images/news/search_03.png")),
            img2: buildImg(require("@/assets/wap/images/news/search_03-05.png")),
            img3: buildImg(require("@/assets/wap/images/news/search_03-07.png")),
            newlist: [],
            NewType: "top",
            shownoresault: false
        };
    },
    created() {

    },
    computed: {
        ...mapGetters(["UserInfo", "ServerTime", "userTime"]),
        emptyNews() {
            return this.newlist.length ? true : false
        }
    },
    watch: {
        searchValue(newVal) {
            if (newVal == "") {
                this.showData = true
            }
        },
    },
    methods: {
        changeContetn(params) { },
        jumpLinks(url) {
            window.jumpLink(url, "_router");
        },
        filterData() {
            this.showData = false;
            this.getNews();
        },
        // 点赞次数随机
        random(lower, upper) {
            return Math.floor(Math.random() * (upper - lower + 1)) + lower;
        },
        async getNews() {
            let Result = await this.$store.dispatch('QueryNewsByKey', { 'input': this.searchValue });
            if (Result.StatusCode == "0") {
                this.newlist = Result.Data
                if (!Result.Data.length) {
                    this.shownoresault = true
                }
            } else {
                if (Result.Message == "未登录") {
                    clearUser();

                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: Result.Message
                });
                return
            }
        },
        del(params) {
            // 删除当前选项
            this.newlist = this.newlist.filter(item => {
                return item != params
            })
        },
        $_handleClick(index, gohref) {
            const that = this;
            return function (event, start, end) {
                /*
                *   event 为事件实例
                *   start end 分别包含事件起始信息： X  --> 横坐标 | Y --> 纵坐标 | T --> 时间戳 
                *   index、gohref 为方法传参
                */
                // if (Math.abs(start.Y - end.Y) <= 10) {
                that.newName = gohref;
                that.isModalNewsDetail = true
                // }
            }
        },
        $_isModelClose() {
            this.isModalNewsDetail = false;
        }
    },
    components: {
        toolbar,
        NewsDetail
    },
    mounted() { }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.HomePage {
    // background-color: #f5f5f5;
    .empty {
        font-size: 0.75rem;
        text-align: center;
        padding-top: 5rem;
    }
    .contentMainBox {
        padding: 0.25rem 0.65rem 20% 0.65rem;
        .searchDefaultBOX {
            color: #6c6c6c;
            > h3 {
                text-align: center;
                padding-top: 1.9rem;
                font-weight: normal;
            }
            .searchDefault {
                width: 80%;
                display: flex;
                margin: 1.25rem auto;
                text-align: center;
                li {
                    flex: 1;
                    img {
                        width: 75%;
                    }
                }
            }
        }
        .contentMain {
            li {
                font-size: 0.55rem;
                .NewList {
                    width: 100%;
                    position: relative;
                    padding-bottom: 30%;
                    border-bottom: 1px solid #efefef;
                    &:last-child {
                        border-bottom: none;
                    }
                    .lefticon {
                        position: absolute;
                        bottom: 0.25rem;
                        left: 0;
                        color: #9e9e9e;
                        span {
                            display: inline-block;
                            vertical-align: middle;
                            i,
                            em {
                                vertical-align: middle;
                                font-style: normal;
                            }
                            &:nth-child(2) {
                                margin-left: 0.35rem;
                            }
                        }
                    }
                    .righticon {
                        position: absolute;
                        bottom: 0.25rem;
                        left: 55%;
                    }
                    .leftSide {
                        position: absolute;
                        top: 0.35rem;
                        left: 0;
                        width: 62.5%;
                        p {
                            display: -webkit-box;
                            -webkit-box-orient: vertical;
                            -webkit-line-clamp: 4;
                            overflow: hidden;
                        }
                    }
                    .rightSide {
                        position: absolute;
                        top: 0.35rem;
                        right: 0;
                        width: 36%;
                        img {
                            width: 100%;
                            height: 100%;
                        }
                    }
                }
                .newDel {
                    text-align: right;
                    border-bottom: 1px solid #efefef;
                    .iconfont {
                        display: inline-block;
                    }
                }
            }
            .NewListIMG {
                .Title {
                    height: 1.5rem;
                    line-height: 1.5rem;
                    font-size: 0.55rem;
                    font-weight: normal;
                    color: #303030;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                }
                .imageBox {
                    display: flex;
                    dd {
                        flex: 1;
                        &:nth-child(1) {
                            padding-right: 0.1rem;
                        }
                        &:nth-child(2) {
                            padding: 0 0.05rem;
                        }
                        &:nth-child(3) {
                            padding-left: 0.1rem;
                        }
                        img {
                            width: 100%;
                        }
                    }
                }
                .shiwTime {
                    height: 1.25rem;
                    margin-top: 0.25rem;
                    position: relative;
                    width: 100%;
                    .left {
                        position: absolute;
                        top: 0;
                        left: 0;
                        vertical-align: middle;
                        color: #9e9e9e;
                        span {
                            vertical-align: middle;
                            display: inline-block;
                            em {
                                font-style: normal;
                            }
                            &:nth-child(2) {
                                margin-left: 0.15rem;
                            }
                        }
                    }
                    .right {
                        position: absolute;
                        right: 0;
                        top: 0;
                    }
                }
            }
        }
    }
}

// 搜索栏

.searchBox {
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: center;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 50px;
    background: #ffffff;
    li.leftSide {
        flex: 1;
        .icon-back-arrow {
            color: #4d4d4d;
            font-size: 1.2rem;
        }
    }
    li.rightSide {
        flex: 16;
        position: relative;
        input {
            background: #f5f5f5;
            font-size: 16px;
            display: block;
            width: 96%;
            height: 40px;
            line-height: 40px;
            padding-left: 12%;
            margin: 0 auto;
            color: #696969;
            border: 1px solid #ffffff;
            outline: none;
            border-radius: 7px;
        }
        .icon-search {
            position: absolute;
            left: 6%;
            top: 3px;
            color: #cfcfcf;
            font-size: 24px;
        }
        .icon-guanbi1 {
            position: absolute;
            right: 8%;
            top: 7px;
            color: #9e9e9e;
            font-size: 18px;
        }
    }
    li.SearchSide {
        flex: 2;
        color: #4d4d4d;
        font-size: 0.65rem;
    }
}
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>



