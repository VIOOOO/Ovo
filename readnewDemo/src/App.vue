<template>
    <div class="global-body" v-show="show">

        <router-view name="header"></router-view>
        <!-- <transition name="router-fade" mode="out-in"> -->
        <router-view />
        <!-- </transition> -->
        <transition name="router-fade-3" mode="out-in">
            <router-view name="patch" />
        </transition>
        <router-view :key="$route.fullPath" name="footer"></router-view>
        <alertTip></alertTip>
        <!-- 全屏loader -->
        <loading></loading>
    </div>
</template>

<script>
import alertTip from "@/components/pc/common/alertTip";
import TYPES from "@/store/mutation-types";
const loading = () => import('@/components/pc/common/loading')
import { cookie, getCurrentWeek, getCurrentMonth, getNowFormatDate,clearUser } from "@/config/env";
import jsCookie from 'js-cookie';
import { mapGetters } from "vuex";
import { jumpLink } from "@/config/lazy";
import xdhelper from 'xdhelper';
export default {
    data() {
        return {
            show: false,
            timer: null
        };
    },
    async created() {
        const that = this;
        document.onselectstart=new Function("return true");
        try {
            //获取服务器时间
            await this.$store.dispatch('ServerTime');
            setInterval(c => {
                this.$store.commit("ServerTime", new Date($local.state.ServerTime.getTime() + 1000))
            }, 1000)

            // 获取周日期
            let weekT = getCurrentWeek(that.ServerTime);
            if (weekT) {
                let wet = {
                    timeStart: "",
                    timeEnd: "",
                }
                wet.timeStart = this.$_changeTime(weekT[0])
                wet.timeEnd = this.$_changeTime(weekT[1])
                console.log(this.$_changeTime(weekT[0]))
                console.log(this.$_changeTime(weekT[1]))
                this.$store.commit('weekTime', wet)
            }

            // 获取月日期
            let monthT = getCurrentMonth(that.ServerTime);
            if (monthT) {
                let mond = {
                    timeStart: "",
                    timeEnd: "",
                }
                mond.timeStart = this.$_changeTime(monthT[0])
                mond.timeEnd = this.$_changeTime(monthT[1])
                console.log(this.$_changeTime(monthT[0]))
                console.log(this.$_changeTime(monthT[1]))
                

                this.$store.commit('monthTime', mond)
            }
        }
        catch (e) { }
    

        

    },
    watch: {
        // Login(NewVal) {
        //     if (NewVal) {
        //         // 获取代理信息
        //         this.$store.dispatch('AgentGet');
        //         // 获取代理下家人数
        //         this.$store.dispatch('GetUserCount');
        //         // 获取代理下家活跃人数
        //         this.$store.dispatch('GetCurrentActiveUserCount');
        //     }
        // },
        $route(NewVal,OldVal){
                this.locationHref();
        },
        AgentGet(NewVal, OldVal) {
            if (NewVal) {
                if (this.AgentGet.cycle == 'WEEK') {
                    this.$store.commit('userTime', this.weekTime)
                }
                if (this.AgentGet.cycle == 'MONTH') {
                    this.$store.commit('userTime', this.monthTime)
                }
                // 测试写定时间范围
                // let tim = {
                //     timeStart: "2018-01-12",
                //     timeEnd: "2019-03-10",
                // }
                // this.$store.commit('userTime', tim)

                if (NewVal !== OldVal) {
                    // 若有新代理信息则修改 cookie 里面的数据
                    // debugger
                    const agentData = cookie.getJSON('agentInfo');
                    if (agentData) {
                        cookie.remove('agentInfo');
                    }
                    cookie.set('agentInfo', NewVal, {
                        path: '/'
                    });
                }
            }
        }
    },
    computed: {
        ...mapGetters(["AgentGet", "ServerTime", "weekTime", "monthTime", "userTime"]),
    },
    methods: {
        async locationHref(){
            let that=this;
            console.log(location.href)
            if (location.href.toString().lastIndexOf("username") > 0 && location.href.toString().lastIndexOf("codeString") > 0) {
                    clearUser();//清除之前的缓存及用户信息
                    const queryParams = xdhelper.getQueryParam(document.location.toString().split("?")[1]);
                    try {
                        let loginDis = await this.$store.dispatch('AgentRedirect', {
                            'username': queryParams.username,
                            'codeString': queryParams.codeString
                        });
                        
                        // this.$store.commit('Login', loginDis)
                        // 写入缓存
                        const loginData = cookie.getJSON('agentLogin');
                        if (loginData) {
                            cookie.remove('agentLogin');
                        }
                        cookie.set('agentLogin', loginDis, {
                            path: '/'
                        });
                        //获取代理信息 写入缓存
                        let agentdis = await that.$store.dispatch('AgentGet');
                        const agentData = cookie.getJSON('agentInfo');
                        if (agentData) {
                            cookie.remove('agentInfo');
                        }
                        cookie.set('agentInfo', agentdis, {
                            path: '/'
                        });
                        this.$_linkUrl('/Home?Data=Refresh', '_router')
                        // $local.vm._router.push('/Home');
                    }
                    catch (e) { }
                    }else{
                        // cookie 读取 Authorization
                        const loginData = cookie.getJSON('agentLogin');
                        const agentData = cookie.getJSON('agentInfo');
                        if (loginData) {
                            // that.$store.commit('Login', loginData);
                        }
                        if (agentData) {
                            that.$store.commit('AgentGet', agentData);
                        }
                    }
        },
        $_changeTime(val) {
            return getNowFormatDate(val, 'YYYY-MM-DD', '-')
        },
        $_linkUrl(url, way) {
            const that = this;
            window.jumpLink(url, way)
        },

    },
    components: {
        alertTip,
        loading
    },
    mounted() {
        this.locationHref()
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


<style scoped>
.global-body {
    height: 100%;
}
a,
a:-webkit-any-link {
    text-decoration: none;
    color: initial;
}
.router-fade-enter-active,
.router-fade-leave-active {
    transition: opacity 0.2s;
}
.router-fade-enter,
.router-fade-leave-active {
    opacity: 0.8;
}
.row-body,
.row-main {
    height: 100%;
}

.router-fade-3-enter-active,
.router-fade-3-leave-active {
    transition: opacity 2s;
}
.router-fade-3-enter,
.router-fade-3-leave-active {
    opacity: 0.2;
}
</style>



