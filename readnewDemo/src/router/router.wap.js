// import HomePage from '../page/wap/index.vue';
import { isApp } from '@/config/env';
/**
 * 引入路由
 */
// import activityRouter from './router.activity'
const PanelLeftPage = () => import('@/components/wap/common/panelLeft.vue')
const Home = () => import('../page/wap/Member/Home.vue')
const NewsDetail = () => import('../page/wap/Member/NewsDetail.vue')
const SearchNews = () => import('../page/wap/Member/SearchNews.vue')
const PostIt = () => import('../page/wap/Member/PostIt.vue')
const MyCenter = () => import('../page/wap/Member/MyCenter.vue')
const Register = () => import('../page/wap/CN/Register.vue')
const Login = () => import('../page/wap/CN/Login.vue')
const BillingRecord = () => import('../page/wap/CN/BillingRecord.vue')
const BillingStatus = () => import('../page/wap/CN/BillingStatus.vue')
const ChangePassword = () => import('../page/wap/CN/ChangePassword.vue')
const PrivacyPolicy = () => import('../page/wap/CN/PrivacyPolicy.vue')
const PrivacyPolicylogin = () => import('../page/wap/CN/PrivacyPolicylogin.vue')
const FrequentProblems = () => import('../page/wap/CN/FrequentProblems.vue')
const ContactService = () => import('../page/wap/CN/ContactService.vue')
const ContactServiceCash = () => import('../page/wap/CN/ContactServiceCash.vue')

const UserInfor = () => import('../page/wap/CN/UserInfor.vue')
const UpdateInfo = () => import('../page/wap/CN/UpdateInfo.vue')
const WithDraw = () => import('../page/wap/Member/WithDraw.vue')
const ThirdPayment = () => import('../page/wap/Member/ThirdPayment.vue')
const AddUserBank = () => import('../page/wap/Member/AddUserBank.vue')
const AddUserInvite = () => import('../page/wap/Member/AddUserInvite.vue')



let isFirst = true;
let routerConfig = [{
        path: '/',
        tabIndex: 0,
        redirect: function(route, resolve, reject) {
            if (isApp) {
                resolve("/Home");
                setTimeout(() => {
                    $local.vm.$store.commit('indexVal', 0)
                }, 0)
            } else {
                if (!isFirst || location.pathname == "/") {
                    resolve("/Home");
                    setTimeout(() => {
                        $local.vm.$store.commit('indexVal', 0)
                    }, 0)

                } else {
                    resolve(location.pathname);
                }
            }
            isFirst = false;
        }
    },
    {
        path: '/Home',
        tabIndex: 0,
        component: Home,
    },
    {
        path: '/NewsDetail/:NewId',
        tabIndex: 0,
        component: NewsDetail,
    },
    {
        path: '/Member/WithDraw',
        tabIndex: 0,
        needAuthencation: true,
        component: WithDraw,
    },
    {
        path: '/Member/ThirdPayment',
        tabIndex: 0,
        needAuthencation: true,
        component: ThirdPayment,
    },
    {
        path: '/Member/AddUserBank',
        tabIndex: 0,
        needAuthencation: true,
        component: AddUserBank,
    },
    {
        path: '/Member/AddUserInvite',
        tabIndex: 0,
        // needAuthencation: true,
        component: AddUserInvite,
    },
    {
        path: '/panelLeft',
        component: PanelLeftPage,
    },
    {
        path: '/CN/Register',
        component: Register,
    },
    {
        path: '/CN/Login',
        // needAuthencation: true,
        component: Login,
    },
    {
        path: '/CN/BillingRecord',
        needAuthencation: true,
        component: BillingRecord,
    },
    {
        path: '/CN/BillingStatus',
        needAuthencation: true,
        component: BillingStatus,
    },
    
    {
        path: '/CN/ChangePassword',
        needAuthencation: true,
        component: ChangePassword,
    },
    {
        path: '/CN/PrivacyPolicy',
        // needAuthencation: true,
        component: PrivacyPolicy,
    },
    {
        path: '/CN/PrivacyPolicylogin',
        // needAuthencation: true,
        component: PrivacyPolicylogin,
    },
    {
        path: '/CN/UserInfor',
        // needAuthencation: true,
        component: UserInfor,
    },
    {
        path: '/CN/UpdateInfo',
        needAuthencation: true,
        component: UpdateInfo,
    },
    {
        path: '/CN/FrequentProblems',
        component: FrequentProblems,
    },
    {
        path: '/Member/PostIt',
        // needAuthencation: true,
        component: PostIt,
        tabIndex: 1,
    },
    {
        path: '/Member/SearchNews',
        // needAuthencation: true,
        component: SearchNews,
        tabIndex: 0,
    },
    {
        path: '/Member/MyCenter',
        component: MyCenter,
        tabIndex: 2,
    },
    {
        path: '/Member/Home',
        component: Home,
    },
    {
        path: '/CN/ContactService',
        component: ContactService,
    },
    {
        path: '/CN/ContactServiceCash',
        component: ContactServiceCash,
    },
    {
        path: '(.*)',
        needAuthencation: true,
        component: Home,
    },
];

/**
 * 合并活动路由
 */
// activityRouter.forEach(a => {
//     if (a.components) {
//         routerConfig.push({
//             path: a.path,
//             component: a.components.default
//         })
//     }
// })

/**
 * 组件懒加载
 */
routerConfig.forEach(a => {
    const component = a.component;
    if (Object.prototype.toString.call(component) == '[object Function]') {
        a.async = function(routeTo, routeFrom, resolve) {
            setTimeout(() => {
                // console.log($local.state.AgentGet)UserInfo
                if (!a.needAuthencation || $local.state.UserInfo || !arguments.length) {
                    // 如果没有登录需求，或者已经登录  才能进入路由
                    component.call().then(vc => resolve && resolve({ component: vc.default }));
                } else {
                    // console.log("无登录信息前往登录页")
                    window.jumpLink("/CN/Login", '_router')
                }
                if (arguments.length) {
                    if (!a.tabIndex) {
                        setTimeout(() => {
                            $local.vm.$store.commit('indexVal', 0)
                        }, 0)

                    } else {
                        setTimeout(() => {
                            $local.vm.$store.commit('indexVal', a.tabIndex)
                        }, 0)

                    }
                }

            }, 0)
        }
        delete a.component;
    }
    /**
     * 默认禁用页面切换动画效果
     */
    if (!a.options) {
        a.options = {
            animate: false,
        }
    }
})
/**
 * 组件预加载
 */
try {
    if (!isApp) {
        setTimeout(() => {
            routerConfig.forEach(a => {
                if (Object.prototype.toString.call(a.async) == '[object Function]') {
                    a.async.call()
                }
            })
        }, 4000)
    }
} catch (e) {

}

export default routerConfig;