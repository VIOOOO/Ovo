<template>
    <f7-page class="contactServicePages">
        <navbar title="联系客服" back="/Member/MyCenter"></navbar>
        <div class="section">
            <ul class="liaison">
                <li v-for="(fItem ,find) in liaisonList" :key="find">
                    <div class="faqTitle">
                        <img :src="fItem.tit" alt=""> ：
                    </div>
                    <div class="faqExplain">{{fItem.exp}}</div>
                </li>
            </ul>
        </div>
        <!-- 全屏loader -->
        <!-- <loaderPage :bgBlack="true"></loaderPage> -->
    </f7-page>
</template>

<script>
import {
    prefix,
    buildImg,
    cookie,
    numbersAndLetters,
    clearUser
} from "@/config/env";
import navbar from "@/components/wap/common/nosearchnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from "js-cookie";

let cache = new wsCache();
export default {
    data() {
        const liaisonList = [
            // {
            //     tit: buildImg(require("@/assets/wap/images/liaison/iconEmail.png")),
            //     exp: "123456789"
            // },
            {
                tit: buildImg(require("@/assets/wap/images/liaison/iconQQ.png")),
                exp: "2438278831"
            },
            // {
            //     tit: buildImg(require("@/assets/wap/images/liaison/iconWechat.png")),
            //     exp: "123456789"
            // },
        ]
        return {
            liaisonList,
            logoIcon: buildImg(require("@/assets/wap/images/logo.png")),
            loginIcon01: buildImg(
                require("@/assets/wap/images/Login/loginIcon01.png")
            ),
            loginIcon02: buildImg(
                require("@/assets/wap/images/Login/loginIcon02.png")
            )
        };
    },
    created() { },
    computed: {
        ...mapGetters(["UserInfo"])
    },
    components: { navbar },
    methods: {
        jumpLink(url) {
            window.jumpLink(url, "_router");
        }
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.contactServicePages {
    // background: #f5f5f5;
    .section {
        padding: 0.3rem 0.6rem 4rem;
        width: 100%;
        .liaison {
            > li {
                background: #fff;
                display: flex;
                justify-content: flex-start;
                align-items: center;
                padding: 0.4rem 0.6rem;
                margin-bottom: 0.4rem;
                border-radius: 8px;
                .faqTitle {
                    > img {
                        width: 1.8rem;
                        vertical-align: middle;
                    }
                }
                .faqExplain {
                    font-size: 0.9rem;
                    padding-left: 0.2rem;
                }
            }
        }
    }
}
// 搜索栏

// .searchBox {
//   background: #ffffff;
//   display: flex;
//   width: 100%;
//   align-items: center;
//   justify-content: center;
//   border-bottom: 1px solid #fac307;

//   li.leftSide {
//     flex: 1;
//     .icon-back-arrow {
//       color: #ffc001;
//       font-size: 1.35rem;
//     }
//   }
//   li.rightSide {
//     flex: 20;
//     position: relative;
//     color: #030303;
//     text-align: center;
//     text-indent: -15%;
//     font-size: 0.7rem;
//     font-weight: bold;
//   }
// }
</style>


