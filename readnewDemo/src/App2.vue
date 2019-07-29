<template>
    <!-- App -->
    <div id="app">

        <!-- Statusbar -->
        <!-- <f7-statusbar></f7-statusbar> -->

        <!-- Left Panel -->
        <f7-panel left reveal theme-dark>
            <f7-view url="/panelLeft/"></f7-view>
        </f7-panel>

        <!-- Main View -->
        <f7-view id="main-view" url="/" main></f7-view>

        <!--提示框-->
        <alertTip></alertTip>

        <!-- 获取值提示框 -->
        <CustomAlertTip></CustomAlertTip>
        <!-- 我的邀请 -->
        <MyInvitation></MyInvitation>
        <!-- 全屏loader -->
        <loaderPage :bgBlack="true"></loaderPage>

    </div>
</template>

<script>
import TYPES from "@/store/mutation-types";
import { cookie, getCurrentWeek, getCurrentMonth, getNowFormatDate } from "@/config/env";
import jsCookie from 'js-cookie';
import { mapGetters } from "vuex";
import { jumpLink } from "@/config/lazy";
import loaderPage from '@/components/wap/common/loaderPage';
import xdhelper from 'xdhelper'
const alertTip = () => import('@/components/wap/common/alertTip')
const CustomAlertTip = () => import('@/components/wap/common/CustomAlertTip')
const MyInvitation = () => import('@/components/wap/common/MyInvitation')

export default {
    data() {
        return {
            show: false,
            timer: null
        };
    },

    async created() {
        let that=this;
        const UserInfo = cookie.getJSON('UserInfo');
        if (UserInfo) {
            that.$store.commit('UserInfo', UserInfo);
        }

    },
    watch: {
    },
    components: {
        alertTip,
        loaderPage,
        CustomAlertTip,
        MyInvitation
    },
    computed: {
        ...mapGetters(["UserInfo"]),
    },
    methods: {


    },
    mounted() {
        if (!this.show && !this.timer) {
            const that = this;
            document.getElementById("dj_before_loading").className =
                "dj_before_loading_fade";
            this.timer = setTimeout(() => {
                that.show = true;
                that.$nextTick(() => {
                    /** 动画隐藏 */
                    document.getElementById("dj_before_loading").style.display = "none";
                });
            }, 1000);
        }
    }
};
</script>
