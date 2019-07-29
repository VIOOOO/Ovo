<template>
    <f7-page class="login">
        <navbar title="绑定提现信息" back="AnimationBack"></navbar>
        <section class="addUserBankBlock">
            <ul v-if="UserInfo" class="userInfo">
                <li>
                    <div class="left"><span>*</span>绑定QQ</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-if="!MyUserBankinfo.QQ||MyUserBankinfo.QQ=='null'" v-model="QQ" value="" maxlength="15" placeholder="请输入您的QQ(填)">
                        <input v-inputprevent type="text" v-else v-model="MyUserBankinfo.QQ" value="" disabled>
                    </div>
                </li>
            </ul>
            <ul class="userMsg">
                <li class="add">
                    请保证您的QQ号是一个太阳级别,方便提现客服打款。
                </li>
                <li class="addbank">
                    <strong>绑定银行卡</strong><em>(极速提现并奖励两元)</em>
                </li>
                <li class="addstyle">
                    为了 保障您您的账户资金安全,请填写本人的银行卡信息。
                </li>
            </ul>
            <ul class="userInfo">
                <li>
                    <div class="left">姓名：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-if="!MyUserBankinfo.BankAccount||MyUserBankinfo.BankAccount=='null'" v-model="BankAccount" value="" placeholder="请输入您的真实姓名">
                        <input v-inputprevent type="text" v-else v-model="MyUserBankinfo.BankAccount" value="" disabled>
                    </div>
                </li>
                <li>
                    <div class="left">卡号：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-if="!MyUserBankinfo.BankCard||MyUserBankinfo.BankCard=='null'" value="" v-model="BankCard" placeholder="请输入您的银行卡号">
                        <input v-inputprevent type="text" v-else v-model="MyUserBankinfo.BankCard" value="" disabled>
                    </div>
                </li>
                <li>
                    <div class="left">开户银行：</div>
                    <div class="inp">
                        <input v-inputprevent type="text" v-if="!MyUserBankinfo.BankName||MyUserBankinfo.BankName=='null'" value="" v-model="BankName" placeholder="请输入您的开户行名称">
                        <input v-inputprevent type="text" v-else v-model="MyUserBankinfo.BankName" value="" disabled>
                    </div>
                </li>

            </ul>
            <div class="inputWrap">
                <input class="col button button-fill submit" @click="AddUserBank" type="button" :value="ClickMark?'完成':'提交中...'">
            </div>
        </section>

    </f7-page>
</template>

<script>
import { prefix, buildImg, cookie, numbersAndLetters, clearUser, realNamePattern, qqPattern, numericPattern, bankCardNumPattern } from "@/config/env";
import navbar from "@/components/wap/common/nosearchnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from 'js-cookie'

let cache = new wsCache();
export default {
    data() {
        return {
            ClickMark: true,
            QQ: "",
            BankAccount: "",
            BankCard: "",
            BankName: "",
            MyUserBankinfo: {
                QQ: "",
                BankAccount: "",
                BankCard: "",
                BankName: ""
            }
        }
    },
    created() {
        this.GetMyUserBankinfo()
    },
    computed: {
        ...mapGetters(["UserInfo", "CustomAlertTip", "PhoneNum", "deviceUuid", "verifiyCode", "WithdrawalMethod", "WithdMoNey"])
    },
    components: { navbar },
    methods: {
        jumpLink() {
            window.jumpLink('/Member/ThirdPayment', '_router');
        },
        async GetMyUserBankinfo() {
            this.$store.dispatch("LoaderPage", true);
            let resault = await this.$store.dispatch("GetMyUserBank");
            this.$store.dispatch("LoaderPage", false);
            if (resault.Data instanceof Array && resault.Data.length) {
                let lastOne = resault.Data.length - 1
                this.MyUserBankinfo = resault.Data[lastOne]
            }
        },
        async AddUserBank() {
            let that = this;
            if ((!that.MyUserBankinfo.QQ && !that.QQ) || (!that.MyUserBankinfo.QQ && !qqPattern.test(that.QQ))) {
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "提示",
                    content: "请填写真实有效的QQ号以方便提款"
                });
                return
            }
            if (!that.BankAccount && !that.BankCard && !that.BankName) {
                that.BankAccount = "";
                that.BankCard = ""
                that.BankName = ""
            } else {
                // debugger
                if (that.BankAccount && that.BankCard && that.BankName) {
                    if (!realNamePattern.test(that.BankAccount)) {
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "提示",
                            content: "请输入您的真实姓名"
                        });
                        return
                    }
                    if (!bankCardNumPattern.test(that.BankCard)) {
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "提示",
                            content: "请输入真实有效的银行卡号"
                        });
                        return
                    }

                } else {
                    that.$store.commit(TYPES.ALERT_TIP, {
                        show: true,
                        title: "提示",
                        content: "请完善您要绑定的银行卡的信息"
                    });
                    return
                }
            }
            that.$store.dispatch("LoaderPage", true)
            let ResualtData = await this.$store.dispatch('UserWithdraw', {
                balance: this.WithdMoNey,
                remark: ""
            })
            if (ResualtData.StatusCode == "0") {
                this.$store.dispatch("LoaderPage", false)
                this.AddUserBankEvent(ResualtData.Data)
            } else {
                this.$store.dispatch("LoaderPage", false)
                if (ResualtData.Message == "未登录") {
                    clearUser();

                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    content: ResualtData.Message
                });
            }

        },
        async AddUserBankEvent(WithdrawId) {
            let that = this;
            let secondResualtData = await this.$store.dispatch('AddUserBank', {
                "Id": "",
                "CreateTime": "",
                "Creator": "",
                "ModifyTime": "",
                "Modifier": "",
                "UserId": that.UserInfo.Id,
                "QQ": that.QQ ? that.QQ : that.MyUserBankinfo.QQ,
                "BankAccount": that.BankAccount ? that.BankAccount : that.MyUserBankinfo.BankAccount,
                "BankCard": that.BankCard ? that.BankCard : that.MyUserBankinfo.BankCard,
                "BankName": that.BankName ? that.BankName : that.MyUserBankinfo.BankName,
                "WithdrawalMethod": that.WithdrawalMethod,
                "WithdrawId": WithdrawId
            })
            if (secondResualtData.StatusCode == "0") {
                that.$store.dispatch("LoaderPage", false)
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "提示",
                    content: "提款申请成功"
                });

                window.jumpLink('/CN/ContactServiceCash', '_router');
            } else {
                that.$store.dispatch("LoaderPage", false)
                if (secondResualtData.Message == "未登录") {
                    clearUser();

                }
                that.$store.commit(TYPES.ALERT_TIP, {
                    show: true,
                    title: "提示",
                    content: secondResualtData.Message
                });
                return
            }
        }
    }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";
.addUserBankBlock {
    // background: #f5f5f5;
    height: 100%;
    padding: 0.6rem;
    .userMsg {
        padding: 0.2rem 0 0.5rem;
        > li {
            display: flex;
            position: relative;
            &.add {
                color: #6d6d6d;
                font-size: 0.5rem;
                padding-bottom: 1.1rem;
            }
            &.addbank {
                font-size: 0.75rem;
                color: #000000;
                vertical-align: bottom;
                line-height: 1.1rem;
                strong,
                em {
                    vertical-align: bottom;
                    font-style: normal;
                }
                span {
                    color: #ed1721;
                    display: inline-block;
                    padding-right: 0.15rem;
                }
                em {
                    font-size: 0.55rem;
                    color: #ed1721;
                    padding-left: 0.25rem;
                }
            }
            &.addstyle {
                line-height: 0.75rem;
                color: #6d6d6d;
                font-size: 0.5rem;
            }
        }
    }
    .userInfo {
        background: #fff;
        margin-bottom: 0.2rem;
        border-radius: 8px;
        li {
            display: flex;
            position: relative;
            padding: 0 0.65rem;
            height: 2.1rem;
            line-height: 2.1rem;

            .td3 {
                position: absolute;
                right: 0.4rem;
                top: 0;
            }
            .left {
                flex: 36;
                font-size: 0.65rem;
                span {
                    color: red;
                    display: inline-block;
                    padding-right: 0.15rem;
                }
            }
            .already {
                position: absolute;
                right: 0.65rem;
                top: 0;
            }
            .inp {
                flex: 100;
                text-align: left;
                input {
                    // height: 2.2rem;
                    width: 100%;
                    display: block;
                    color: #333333;
                    line-height: 2.2rem;
                    &::-webkit-input-placeholder {
                        color: #bfbfbf;
                    }
                    &::-moz-placeholder {
                        /* Mozilla Firefox 19+ */
                        color: #bfbfbf;
                    }
                    &:-moz-placeholder {
                        /* Mozilla Firefox 4 to 18 */
                        color: #bfbfbf;
                    }
                    &:-ms-input-placeholder {
                        /* Internet Explorer 10-11 */
                        color: #bfbfbf;
                    }
                }
            }
        }
    }
    .inputWrap {
        width: 100%;
        margin: 1.75rem auto;
        input {
            font-size: 0.8rem;
            border: none;
            border-radius: 0.3rem;
            height: 1.9rem;
            letter-spacing: 3px;
        }
        .submit {
            background: #ed1721;
            color: #fff;
        }
    }
}
// 搜索栏

// .searchBox {
//     background: #ffffff;
//     display: flex;
//     width: 100%;
//     align-items: center;
//     justify-content: center;
//     border-bottom: 1px solid #fac307;

//     li.leftSide {
//         flex: 1;
//         .icon-back-arrow {
//             color: #ffc001;
//             font-size: 1.35rem;
//         }
//     }
//     li.rightSide {
//         flex: 20;
//         position: relative;
//         color: #030303;
//         text-align: center;
//         text-indent: -15%;
//         font-size: 0.7rem;
//         font-weight: bold;
//     }
// }
.icon-note {
    color: #ffffff;
    font-size: 1.25rem;
}
</style>

