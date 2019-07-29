<template>
    <f7-page class="HomePage">
        <navbar></navbar>
        <section class="enliven">
            <div id="topNav" class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" v-for="(item,index) in depList" @click="changeContetn(item)" :key="index" :class="{active:dep_id==item.department_id}">
                        <span>{{item.department_name}}</span>
                    </div>
                </div>
            </div>
            <pull-to :top-load-method="refresh" :bottom-load-method="BtoRefresh">
                <div v-if="dep_id==1" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon" @click="del(item)"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">{{item.title}}</h2>
                                <dl class="imageBox" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right" @click="del(item)"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==2" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==3" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span></div>
                                        <div class="right"><i class="icon iconfont icon-X"></i>
                                    </div> -->
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==4" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==5" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==6" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==7" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==8" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==9" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==10" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div v-if="dep_id==11" class="contentMain">
                    <ul class="NewListBox">
                        <li v-for="(item,index) in newlist" :key="index" @touchstart="$_handleClick()" @touchend="$_handleClickEnd(item.Id)">
                            <div class="NewList" v-if="(item.thumbnail_pic_s&&!item.thumbnail_pic_s02&&!item.thumbnail_pic_s03)||item.thumbnail_pic_s&&item.thumbnail_pic_s02&&!item.thumbnail_pic_s03">
                                <div class="leftSide">
                                    <p>{{item.title}}</p>
                                </div>
                                <div class="rightSide">
                                    <img :src="item.thumbnail_pic_s" alt="">
                                </div>
                                <!-- <div class="lefticon">
                                    <div>
                                        <i class="icon iconfont icon-shouye_xiaoxi"></i> <em>00</em></span><span>
                                        <i class="icon iconfont icon-zan"></i> <em>{{random(50,120)}}</em></div>
                                </div> -->
                                <div class="righticon"><i class="icon iconfont icon-X"></i></div>
                            </div>
                            <div class="NewListIMG" v-if="item.thumbnail_pic_s&&item.thumbnail_pic_s02&&item.thumbnail_pic_s03">
                                <h2 class="Title">{{item.title}}</h2>
                                <dl class="imageBox">
                                    <dd>
                                        <img :src="item.thumbnail_pic_s" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s02" alt="">
                                    </dd>
                                    <dd>
                                        <img :src="item.thumbnail_pic_s03" alt="">
                                    </dd>
                                </dl>
                                <div class="shiwTime">
                                    <!-- <div class="left">
                                        <span><i class="icon iconfont icon-shouye_xiaoxi"></i> <em>{{item.mesageNum}}</em></span>
                                        <span><i class="icon iconfont icon-zan"></i>
                                            <em>{{random(50,120)}}</em></span>
                                    </div> -->
                                    <div class="right"><i class="icon iconfont icon-X"></i></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>

            </pull-to>
        </section>

        <toolbar slot="fixed"></toolbar>
    </f7-page>
</template>
<script>
import TYPES from "@/store/mutation-types";
import { mapGetters } from "vuex";
import navbar from "@/components/wap/common/navbar";
import toolbar from "@/components/wap/common/toolbar";
import { buildImg, getNowFormatDate, jumpLinUrl, clearUser } from "@/config/env";
import mySwipers from "../../../../static/plugin/swiper.min.js";
import "../../../../static/plugin/swiper.min.css";
import PullTo from 'vue-pull-to'
// import 'swiper/dist/css/swiper.css';
// import mySwipers from "@/assets/wap/images/demo/swiper.min.js";
// import { swiper, swiperSlide } from 'vue-awesome-swiper'

export default {
    data() {
        return {
            mySwiper: false,
            swiperWidth: "",
            maxTranslate: "",
            maxWidth: "",
            dep_id: 0,
            loginDis: "",
            depList: [
                { department_id: 1, department_name: "热点", type: "top" },
                { department_id: 2, department_name: "游戏", type: "youxi" },
                { department_id: 3, department_name: "", type: "yule" },
                { department_id: 4, department_name: "社会", type: "shehui" },
                { department_id: 5, department_name: "国内", type: "guonei" },
                { department_id: 6, department_name: "国际", type: "guoji" },
                { department_id: 7, department_name: "时尚", type: "shishang" },
                { department_id: 8, department_name: "体育", type: "tiyu" },
                { department_id: 9, department_name: "军事", type: "junshi" },
                { department_id: 10, department_name: "科技", type: "keji" },
                // { department_id: 11, department_name: "科技", type: "keji" },
            ],
            newlist: [],
            NewId: "",
            NewType: '',
            loop: 0 // 按钮长按计时

        };
    },
    created() {
        // this.getNews();
        const that = this;
        setTimeout(() => {
            if (that.TopNavTab) {
                that.dep_id = that.TopNavTab ? that.TopNavTab : 1;
                that.changeContetn(that.depList[that.dep_id - 1]);
                // debugger
                // that.mySwiper.on("tap", function (swiper, e) {
                //     console.log(swiper.clickedIndex)
                // })
                that.$_btnSwiperTabFrish(that.mySwiper, that.dep_id - 1)
            }
        }, 200)

    },
    computed: {
        ...mapGetters(["UserInfo", "TopNavTab"])
    },
    watch: {

    },
    methods: {
        $_btnSwiperTabFrish(swiper, tabId) {
            // console.log(swiper+"____"+ tabId)
            const that = this;
            that.dep_name = that.depList[tabId].department_name;
            that.dep_id = that.depList[tabId].department_id;
            let slide, slideLeft, slideWidth, slideCenter, nowTlanslate;
            slide = swiper.slides[tabId];
            slideLeft = slide.offsetLeft;
            slideWidth = slide.clientWidth;
            slideCenter = slideLeft + slideWidth / 2;
            that.mySwiper.setWrapperTransition(300);
            if (slideCenter < that.swiperWidth / 2) {
                that.mySwiper.setWrapperTranslate(0);
            } else if (slideCenter > that.maxWidth) {
                that.mySwiper.setWrapperTranslate(that.maxTranslate);
            } else {
                nowTlanslate = slideCenter - that.swiperWidth / 2;
                that.mySwiper.setWrapperTranslate(-nowTlanslate);
            }
        },
        $_btnSwiperTab(swiper) {
            const that = this;
            //swiper.clickedIndex(获取到当前点击的索引)
            if (that.dep_id == that.depList[swiper.clickedIndex].department_id) {
                return;
            }
            that.loading_show = true;
            that.dep_name = that.depList[swiper.clickedIndex].department_name;
            that.dep_id = that.depList[swiper.clickedIndex].department_id;

            // 保存当前页签位置
            that.$store.commit('TopNavTab', that.dep_id);

            var slide, slideLeft, slideWidth, slideCenter, nowTlanslate;
            slide = swiper.slides[swiper.clickedIndex];
            slideLeft = slide.offsetLeft;
            slideWidth = slide.clientWidth;
            slideCenter = slideLeft + slideWidth / 2;
            that.mySwiper.setWrapperTransition(300);
            if (slideCenter < that.swiperWidth / 2) {
                that.mySwiper.setWrapperTranslate(0);
            } else if (slideCenter > that.maxWidth) {
                that.mySwiper.setWrapperTranslate(that.maxTranslate);
            } else {
                nowTlanslate = slideCenter - that.swiperWidth / 2;
                that.mySwiper.setWrapperTranslate(-nowTlanslate);
            }
        },
        // 点赞次数随机
        random(lower, upper) {
            return Math.floor(Math.random() * (upper - lower + 1)) + lower;
        },
        async getNews() {
            let Result = await this.$store.dispatch('News', { 'Id': 0, "type": this.NewType });
            if (Result.StatusCode == "0") {
                this.newlist = Result.Data
                this.NewId = this.newlist[this.newlist.length - 1].Id
            } else {
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: Result.Message
                });
            }

        },
        async refresh(loaded) {
            let Result = await this.$store.dispatch('News', { 'Id': 0, "type": this.NewType });
            if (Result.StatusCode == "0") {
                this.newlist = Result.Data
                this.NewId = this.newlist[this.newlist.length - 1].Id
            } else {
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: Result.Message
                });
            }
            loaded('done')
        },
        async BtoRefresh(loaded) {
            debugger
            let Result = await this.$store.dispatch('News', { 'Id': this.NewId, "type": this.NewType });
            if (Result.StatusCode == "0") {
                this.newlist = Result.Data
                this.NewId = this.newlist[this.newlist.length - 1].Id
                let oldArry = this.newlist
                this.newlist = oldArry.concat(this.newlist)
            } else {
                if (Result.Message == "未登录") {
                    clearUser();
                    window.jumpLink('/Member/Home', '_router');
                }
                this.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: Result.Message
                });
            }

            loaded('done')
        },
        jumpLink(params) {
            jumpLinUrl(`/NewsDetail/${params}`, '_router')
        },
        changeContetn(item) {
            this.NewType = item.type;
            this.getNews()
        },
        del(params) {
            // 删除当前选项
            this.newlist = this.newlist.filter(item => {
                return item != params
            })
        },
        // 避免长按触发下拉刷新时候 触发点击
        $_handleClick() {
            clearInterval(this.loop);
            this.loop = setInterval(() => {
                this.loop = this.loop + 5;
            }, 5)
        },
        $_handleClickEnd(gohref) {
            if (this.loop < 350) {
                this.jumpLink(gohref);
            }
        }
    },
    components: {
        navbar,
        toolbar,
        PullTo

    },
    mounted() {
        var that = this;
        setTimeout(function () {
            that.mySwiper = new mySwipers("#topNav", {
                freeMode: true,
                freeModeMomentumRatio: 0.5,
                slidesPerView: "auto",
                resistanceRatio: 0.7
            });
            that.swiperWidth = that.mySwiper.container["0"].clientWidth;
            that.maxTranslate = that.mySwiper.maxTranslate();
            that.maxWidth = -that.maxTranslate + that.swiperWidth / 2;
            that.mySwiper.on("tap", function (swiper, e) {
                that.$_btnSwiperTab(swiper)
            });
        }, 100);
    }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.HomePage {
    // background-color: #f5f5f5;
    .contentMain {
        padding: 0.25rem 0.65rem 30% 0.65rem;
        overflow: auto;
        li {
            font-size: 0.55rem;
            .NewList {
                width: 100%;
                position: relative;
                padding-bottom: 32.5%;
                border-bottom: 1px solid #efefef;
                &:last-child {
                    border-bottom: none;
                }
                .lefticon {
                    position: absolute;
                    bottom: 0.25rem;
                    left: 0;
                    color: #9e9e9e;
                    div {
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
                    z-index: 10000;
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
                    position: relative;
                    padding-bottom: 25%;
                    img {
                        position: absolute;
                        top: 0;
                        left: 0;
                    }
                    &:nth-child(1) {
                        img {
                            width: 99%;
                        }
                    }
                    &:nth-child(2) {
                        img {
                            width: 99%;
                            left: 1%;
                        }
                    }
                    &:nth-child(3) {
                        img {
                            width: 98%;
                            left: 2%;
                        }
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
    .enliven {
        padding-top: 1.5rem;
        #topNav {
            width: 100%;
            /* overflow: hidden; */
            font: 0.67rem/1.78rem hiragino sans gb, microsoft yahei, simsun;
            // border-bottom: 2px solid #fff6d3;
            position: fixed;
            top: 50px;
            left: 0;
            background: #ffffff;
        }
        #topNav .swiper-slide {
            padding: 0 10px;
            letter-spacing: 2px;
            // width: 3rem;
            width: 3.55rem;
            text-align: center;
            height: 1.5rem;
            line-height: 1.5rem;
        }
        #topNav .swiper-slide span {
            transition: all 0.3s ease;
            display: block;
        }
        #topNav .active span {
            //   transform: scale(1.1);
            font-weight: bold;
            color: #ed171f;
            position: relative;
        }
        #topNav .active span::before {
            content: "";
            position: absolute;
            bottom: 1px;
            left: 50%;
            transform: translate(-50%, 0);
            width: 56%;
            height: 2px;
            background: #ed171f;
            border-radius: 4px;
        }
        img {
            width: 100%;
            line-height: 0;
        }
    }
    .icon-X {
        color: #989898;
        padding: 0.3rem;
        z-index: 1000;
    }
}
</style>
<style>
.vue-pull-to-wrapper {
    position: absolute;
    /* top: 36px; */
    /* left: 0 !important; */
    /* height: 100% ; */
    width: 100%;
    /* padding-bottom: 20%; */
}
</style>




