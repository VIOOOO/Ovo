<template>
  <f7-page class="mainBox">
    <img class="i-hid" :src="manshare">
    <div class="register">
      <img class="c-invite-share" :src="cinviteshare">
      <div class="fixed-invite-cont">
        <div class="word">
          <p>阅读赚取奖金 · 新注册用户领现金红包</p>
        </div>
        <div class="input">
          <div class="input-letf">
            <img :src="telephone">
          </div>
          <div class="input-right">
            <input type="text" v-model="PhoneNumb" name value placeholder="输入手机号领取">
          </div>
        </div>
        <div class="input">
          <div class="input-letf">
             <i class="icon iconfont icon-yanzhengma"></i>
          </div>
          <div class="input-right">
            <input type="text" name value v-model="verifiyCode" placeholder="输入手机验证码">
            
          </div>
          <em class="getCode"  @click="getCode">{{btntxt}}</em>
        </div>
        <div class="submit" @click="InviteEevent" >
          <span>立即领取</span>
        </div>
        <p class="download-text" @click="show=true">下载不了点这里&gt;&gt;</p>
      </div>
    </div>
    <div class="tips-mask" v-if="show"  @click="show=!show">
      <img class="tips-pic" :src="tips">
    </div>
    <!-- <p class="toast-text" >请输入正确手机号码</p> -->
    <div class="success success1" v-if="show2" @click="show2=!show2">
      <div class="bgcolor">
        <div class="popupBox">
          <img class="icon-popup-success" :src="iconpopupsuccess">
          <div class="content-1">
            <p>恭喜您的奖金已到账</p>
          </div>
          <div class="content-3">
            <p>提示 : 注册账号必须与下载APP的手机号码保持一致.</p>
          </div>
          <div class="popup-submit">
            <span>立即下载提现</span>
          </div>
        </div>
      </div>
    </div>
  </f7-page>
</template>

<script>
import {
  prefix,
  buildImg,
  cookie,
  numbersAndLetters,
  clearUser,
  realNamePattern,
  contactNoPattern
} from "@/config/env";
import Commonnavbar from "@/components/wap/common/Commonnavbar";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";
import wsCache from "web-storage-cache";
import jsCookie from "js-cookie";

let cache = new wsCache();
export default {
  data() {
    return {
      ClickMark: true,
      manshare: buildImg(require("@/assets/wap/images/Invite/man-share.png")),
      cinviteshare: buildImg(require("@/assets/wap/images/Invite/c-invite-share.png")),
      telephone: buildImg(require("@/assets/wap/images/Invite/telephone.png")),
      tips: buildImg(require("@/assets/wap/images/Invite/tips@2x.png")),
      iconpopupsuccess: buildImg(require("@/assets/wap/images/Invite/icon-popup-success.png")),
      show:false,
      show2:false,
      btntxt: "获取验证码",
      disableRedButton: true,
      disabledVerify: true,
      PhoneNumb:"",
      verifyTimer: null,
      time: 60,
      verifiyCode:"",
      inviteCode:""

    };
  },
  created() {},
  computed: {
    ...mapGetters(["UserInfo",]),
    filterPhon: function() {
                return contactNoPattern.test(this.PhoneNumb.replace(/\s/g, ""));
     }
  },
  components: { Commonnavbar },
  mounted(){
      if(location.href.lastIndexOf("inviteCode=")){
          this.inviteCode=location.href.toString().split("=")[1]
      }
  },
  methods: {
    jumpLink(params) {
      this.$store.commit("WithdrawalMethod", params.name);
      window.jumpLink("/Member/AddUserBank", "_router");
    },
    async getCode(){ 
                const that = this;
                  if(that.filterPhon){
                    if(that.disabledVerify){
                        if (that.time > 0) {
                        that.verifyTimer = setInterval(function() {
                            that.time--;
                            if (that.time <= 0) {
                            clearInterval(that.verifyTimer);
                            that.time = 60;
                            that.btntxt = "获取验证码";
                            that.disabledVerify = true;
                            that.disableRedButton=true;
                            } else {
                            that.btntxt = that.time + "s后重新获取";
                            }
                        }, 1000);
                            that.disabledVerify=false
                        }
                    }else{
                       that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content: that.btntxt
                        }); 
                        return
                    }
                    if(that.disableRedButton){
                        let ResualtData =  await that.$store.dispatch('SendMobileValidateCode', {
                            "Ip": "",
                            "Phone": that.PhoneNumb,
                            "PhoneValidateCode":"3",
                            "Type":1,
                            "Id":"0"
                    })
                    if(ResualtData.StatusCode=="0"){
                            that.disableRedButton=false
                            that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content: "获取验证码成功!"
                        });
                    }else{
                        that.disableRedButton=false
                        that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content: ResualtData.Message
                        });
                    }
                    }
                }else{
                  that.$store.commit(TYPES.ALERT_TIP, {
                            show: true,
                            title: "手机验证",
                            content:"请输入正确的手机号"
                        });
                }

                   
                
        },
    async InviteEevent(){
      if(this.filterPhon&&this.verifiyCode){
          let Result= await this.$store.dispatch('AddUserInvite',{
            inviteCode:this.inviteCode,
            phone:this.PhoneNumb,
            phoneCode:this.verifiyCode
          });
          if(Result.StatusCode=="0"){
                this.show2=true;
          }else{
              this.$store.commit(TYPES.ALERT_TIP, {
                  show: true,
                  content: Result.Message
              });
          }
      }else{
        this.$store.commit(TYPES.ALERT_TIP, {
              show: true,
              title: "提示",
              content:"请输入手机号和验证码"
          });
      }
        
    }
  }
};
</script>



<style lang="scss" scoped>
@import "../../../style/mixin";

  .mainBox{
    background: #fb3221;
  }

  .icon-yanzhengma{
    color: #fb3221;
    font-size: 0.95rem;
  }
  .big-img{
    width: 100%;
    text-align: center;
    margin-top: 0.28rem;
  }
  .big-img img{
    width: 2.06rem;
    text-align: center;
    margin: 0 auto;
  }
  .word{
    width: 97.77%;
    line-height: 1.5rem;
    font-size: 0.65rem;
    margin: 0 auto;
    margin-top: 0.25rem;
  }
  .i-hid {
    display: none;
}
  .word p{
    margin: 0;
    padding: 0;
    text-align: center;
    color: #fff;
  }
  .word span{
    font-size: 0.65rem;
    text-decoration: underline;
  }
  .input{
    position: relative;
    width: 65%;
    height: 1.5rem;
    border: 1px solid #FFAE1E;
    border-radius: 0.25rem;
    margin: 0 auto;
    margin-top: 0.5rem;
    background: #fff;
  }
  .input-letf{
    width: 1.25rem;
    float: left;
    margin: 0.15rem 0 0 0.35rem;
  }
  .input-letf img{
    width: 0.75rem;
  }
  .input-right{
    float: left;
    position: relative;
    
  }
  .getCode{
      position: absolute;
      right: 0.1rem;
      top:0.3rem;
      z-index: 100;
      color: #202020;
      font-style: normal;
    }
  .input-right input{
    border: none;
    outline: medium;
    width:100%;
    display: block;
    height: 1rem;
    font-size: 0.65rem;
    color: #333;
    margin-top: 0.2rem;
    border-left: 1px solid #f44635;
    padding-left: 0.25rem;
    box-sizing: border-box;
    vertical-align: middle;

  }

  .input-right input::placeholder{
    color: #f96c30;
    font-size: 14px;
  }
  .submit,.popup-submit,.warn-submit{
    width: 50%;
    height: 1.4rem;
    margin: 0 auto;
    margin-top: 0.75rem;
    background: -webkit-linear-gradient(right,#ffc000,#ffd450);
    border-radius: 25px;
    text-align: center;
    color: #fff;
  }
  .submit{
    margin-top: 1.25rem;
  }
  .submit span,.popup-submit span{
    font-size: 0.65rem;
    color: #fff;
    line-height: 1.4rem;
    height: 1.4rem;
    display: block;
  }
  .submit span{
    color: #fa3a28;
  }
  .submit {
    animation: btn 0.7s infinite;
  }

  @keyframes btn
  {
    from {transform: scale(1.1);}
    to {transform: scale(0.9);}
  }

  .warn-submit span{
    font-size: 0.18rem;
    color: #fff;
    line-height: 0.4rem;
  }
  .bgcolor{
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.52);
    position: fixed;
    z-index: 5;
    top: 0;
    left: 0;
  }
  .popupBox,.warn-popup{
    width: 90%;
    height: 10rem;
    background: #FFFFFF;
    border-radius: 6px;
    margin: 0 auto;
    margin-top: 10.5rem;
    font-family: SFUIDisplay-Regular;
    /* overflow: hidden; */
    text-align: center;
  }
  .title{
    text-align: center;
    font-size: 0.24rem;
    color: #202020;
    padding-top: 0.18rem;
  }
  .content-1{
    margin: 0 auto;
    width: 80%;
    font-size: 0.65rem;
    color: #ffc000;
    text-align: center;
    line-height: 1.2rem;
  }
  .content-1-p2{
  color: #FFAE1E;
  }
  .content-2{
    width: 77.91%;
    font-size: 0.2rem;
    color: #202020;
    line-height: 1.35rem;
    margin: 0 auto;
    text-align: center;
    margin-top: 0.45rem;
  }
  .content-3{
    width: 82.99%;
    font-size: 0.55rem;
    color: #999;
    line-height: 1.25rem;
    margin: 0.5rem auto;
    text-align: center;
  }
  .warn-popup{
    margin-top: 2.2rem;
    width: 60%;
    height: 30%;
    text-align: center;
  }
  .warn-word{
    width: 100%;
    height: 100px;
    font-size: 0.2rem;
    padding-top: 30px;
  }
  .warn-submit{
    margin-top: 0;
    width: 60%;
    font-size: 0.1rem;
  }

  .toast-text{
    position: fixed;
    left: 10%;
    right: 10%;
    width: 80%;
    bottom: 20px;
    background: rgba(0,0,0,0.6);
    z-index: 1;
    border-radius: 25px;
    font-size: 16px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    color: #fff;;
  }

  .icon-warn{
    position: absolute;
    right: 0.25rem;
    top: 0.25rem;
    width: 0.75rem;
    height: 0.75rem;
    background: url(../../../assets/wap/images/Invite/icon-warn.png) no-repeat center;
    background-size: 0.75rem 0.75rem;
    animation: warn 0.1s 5;

  }

  @keyframes warn
  {
    from {transform: translateX(10px);}
    to {transform: translateX(-10px);}
  }

  .c-invite-share{
    width: 100%;
  }

  .icon-popup-success{
    position: relative;
    top: -1rem;
    width: 3rem;
  }

  .popup-submit {
    width: 70%;
  }

  .download-text{
    text-align: center;
    color: #fbf4f4;
    font-size: 14px;
    margin-top: 10px;
  }

.tips-mask {
  position: fixed;
  left: 0;
  bottom: 0;
  top: 0;
  right: 0;
  z-index: 1;
  background: rgba(0, 0, 0, 0.6);
  text-align: center;
}

.tips-pic {
  display: block;
  margin: 20% auto;
  width: 92%;
}

</style>

