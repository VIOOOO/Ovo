<template>
  <section>
    <div class="bg">
      <div class="topBlock">
        <div class="turntable">
          <div class="turnPosition">
            <div class="conts">
              <div class="box">
                <div class="pointerIcon">
                  <img :src="imgs.pan04" alt="">
                </div>
                <div class="pointerBtn" :class="{'cantrun':cantrunNum}" @click="$_chou()"></div>
                <div class="boxbg boxbgFront" :class="{'tranFront':tranFrontRotat}" :style="{opacity:tranFrontOP}"></div>
                <div class="boxbg tran" :style="{transform:rotate_angle,transitionDuration:rotate_transition+'s'}">
                  <div class="turn">
                    <div :class="{'wheel-bg6':true}">
                      <!-- <div class="prize-list">
                        <ul class="ulOne" >
                          <li v-for="(item,index) in arrOne" :key="index" :style="{ zIndex: item.zIndex,transform: item.deg }"></li>
                        </ul>
                        <ul class="ulTwo" >
                          <li v-for="(item,index) in arrTwo" :key="index"  :style="{ zIndex: item.zIndex,transform: item.deg }"></li>
                        </ul>
                        <div></div>
                      </div> -->
                      <div class="prize-list">
                        <div class="prize-item" v-for="(item,index) in prize_list" :key="index" :style="{transform:item.troter}">
                          <!-- <div class="prize-name">
                            {{item.prizeName}}
                          </div> -->
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>

        </div>
        <div class="timeBlock">
          <div class="timeArea">
            <div class="activityTime">
              开始时间
              <span> {{activityTimeSection}} </span>
              &ensp;
            </div>
            <div class="countDown">
              剩余时间
              <span> {{countDown}} </span>
            </div>
          </div>
          <div class="dowBtn" @click="$_scrollTo">
            <img :src="imgs.sa01" alt="">
          </div>
        </div>
      </div>
    </div>
    <div class="popupBg" v-if="toast_control">
      <div class="popupBlock">
        <p class="puTitle">恭喜获得</p>
        <div class="puBlockA" v-if="!isX">
          <div>存送优惠奖励
            <span>{{hasPrize}}</span>
          </div>
          <div>* 请及时使用！</div>
        </div>
        <div class="puBlockB" v-if="isX">
          <div class="ipImg">iPhone X 一部 <img :src="imgs.bean01" alt=""></div>
          <div>* 请联系客服确认是否折现</div>
        </div>
        <div class="puBtn">
          <div class="puClose" @click="close_toast()">关闭</div>
          <div class="pulinkBtn">
            <a class="palink" href="javascript:jumpLink('/Member/Deposit','_blank')"> 前往存款</a>
          </div>
        </div>
      </div>
    </div>
  </section>

</template>
<script>
export default {
  data() {
    const imgs = {
      sa01: require("../assets/trTwo/sa01.png"),
      pan04: require("../assets/trTwo/pan04.png"),
      bean01: require("../assets/trTwo/bean01.png")
    };
    const prize_list = [
      {
        prizeType: "X", // 奖品值
        prizeName: "iPhone X 256G", // 奖品名称
      },
      {
        prizeType: "100%",
        prizeName: "存送100%",
      },
      {
        prizeType: "50%",
        prizeName: "存送50%",
      },
      {
        prizeType: "40%",
        prizeName: "存送40%"
      },
      {
        prizeType: "35%",
        prizeName: "存送35%"
      },
      {
        prizeType: "30%",
        prizeName: "存送30%"
      }
    ]; //奖品列表
    return {
      imgs,
      prize_list,
      winnum: null, //中奖的下标
      toast_control: false, //抽奖结果和活动规则弹出框控制器
      click_flag: true, //是否可以旋转抽奖
      start_rotating_degree: 0, //转盘初始旋转角度
      rotate_angle: 0, //转盘将要旋转的角度
      rotate_transition: "", //初始化选中的过度属性控制
      tranFrontRotat: false,//假转盘模拟抽奖转动
      tranFrontOP: 1,//假转盘透明
      hasPrize: "", //抽奖之后弹出框信息
      isX: false,//是否是iphoneX
      cantrunNum: true,
      endTime: new Date(),
      nowTime: new Date()
    }
  },
  mounted() {
    let that = this;
    that.setSan()
    setInterval(() => {
      that.nowTime = new Date()
    }, 1000)
  },
  computed: {
    activityTimeSection() {
      const that = this;
      if (true) {
        // let s = that.ServerTime.getHours();
        let s = that.nowTime.getHours();
        if ((s >= 0 && s < 2) || (s >= 12 && s < 14) || (s >= 18 && s < 20)) {
          return "进行中"
        }
        if (s >= 2 && s < 12) {
          return "12:00"
        }
        if (s >= 14 && s < 18) {
          return "18:00"
        }
        if (s >= 20 && s < 23) {
          return "00:00"
        }

      } else {
        return "--:--"
      }

    },
    countDown() {
      const that = this;

      if (that.nowTime) {
        let that = this;
        let s = that.nowTime.getHours();

        that.endTime.setMinutes(0);
        that.endTime.setSeconds(0);
        if (s >= 0 && s < 2) {
          that.endTime.setHours(2)
        }
        if (s >= 12 && s < 14) {
          that.endTime.setHours(14)
        }
        if (s >= 18 && s < 20) {
          that.endTime.setHours(20)
        }
        // that.endTime.setHours(20) //测试

        let t = that.endTime.getTime() - that.nowTime.getTime();
        if (t > 0) {
          let hour = Math.floor((t / 3600000) % 24);
          let min = Math.floor((t / 60000) % 60);
          let sec = Math.floor((t / 1000) % 60);
          hour = hour < 10 ? "0" + hour : hour;
          min = min < 10 ? "0" + min : min;
          sec = sec < 10 ? "0" + sec : sec;
          let format = '';
          format = `${hour}:${min}:${sec}`;
          return format;
        } else {
          return " --:--:-- ";
        }
      } else {
        return " --:--:-- ";
      }
    }
  },
  methods: {
    $_scrollTo() {
      if (isPc) {
        this.inv = document.documentElement.scrollTop || document.body.scrollTop;
        this.time = setInterval(() => {
          window.scrollTo(0, this.inv);
          this.inv = this.inv + 12;
          if (this.inv > 720) {
            clearTimeout(this.time);
          }
        }, 1);
      }

    },
    $_chou() {
      let that = this;
      if (!that.cantrunNum) {
        if (that.activityTimeSection == "12:00" || that.activityTimeSection == "18:00" || that.activityTimeSection == "00:00") {
          alert("每日00:00-02:00；12:00-14:00；18:00-20:00，才能参与活动")
        } 
        return
      }
      that.tranFrontRotat = true;
      that.winnum = Math.floor(Math.random() * Number(that.prize_list.length - 1));//测试

      setTimeout(() => {

        // that.$_m_eventApply().then(data => {
        setTimeout(() => {  //模拟接口

          if (!that.cantrunNum) {
            // this.$store.commit(TYPES.ALERT_TIP, {
            //   show: true,
            //   title: "温馨提示",
            //   content: ""
            // });
            alert("您已领取完成，不能贪心哦！")
            that.tranFrontRotat = false;
            return
          }
          // that.winnum = parseInt(that.applyRes.type)
          that.rotating(that.winnum)
          setTimeout(() => { //假转盘隐藏
            that.tranFrontOP = 0;
            setTimeout(() => {
              that.tranFrontRotat = false;
            }, 1000)
          }, 500)

        }, 6000)


        // })

      }, 1500)

    },
    setSan() {
      let that = this
      that.rotate_angle = "rotate(" + Math.floor(-360 * 100 / that.prize_list.length) / 200 + "deg)";
      that.start_rotating_degree = Math.floor(-360 * 100 / that.prize_list.length) / 200;
      for (var i = 0; i < that.prize_list.length; i++) {
        that.prize_list[i].troter = "rotate(" + Math.floor(360 * 100 / that.prize_list.length) / 100 * (0.5 + Number(i)) + "deg) translateX(-50%)"
      }
    },
    rotating(index) { //转盘转动函数，index值为中奖的下标，后台会返回中奖的id，这边会首先for循环判断中奖的下标
      const that = this;
      that.hasPrize = "";//清除上一次弹窗结果
      that.rotate_transition = 13;// 默认为1s

      if (!that.click_flag) return;
      let result_index = index; // 最终要旋转到哪一块，对应prize_list的下标
      let rand_circle = 52; // 附加多转几圈，2-3
      that.click_flag = false; // 旋转结束前，不允许再次触发

      if (that.start_rotating_degree < 0) {
        that.start_rotating_degree = 0
      } else {
        that.start_rotating_degree = that.start_rotating_degree + Math.floor(360 * 100 / that.prize_list.length) / 200
      }
      let rotate_angleNew = that.start_rotating_degree + 360 * 10 + Math.floor(-360 * 100 / that.prize_list.length) / 200 - Math.floor(360 * 100 / that.prize_list.length) * result_index / 100;
      that.start_rotating_degree = rotate_angleNew;
      that.rotate_angle = "rotate(" + rotate_angleNew + "deg)";

      console.log(that.rotate_angle)
      // 旋转结束后，允许再次触发
      setTimeout(function () {
        that.click_flag = true;
        setTimeout(function () {
          that.game_over(); //弹窗
          that.cantrunNum = false;
        }, 100)
      }, that.rotate_transition * 1000 + 1500); // 延时，保证转盘转完
    },
    game_over() {
      let that = this;

      if (that.prize_list[that.winnum].prizeType == "X") {
        that.isX = true
      } else {
        that.hasPrize = that.prize_list[that.winnum].prizeType
      }
      that.toast_control = true;

    },
    //关闭弹窗
    close_toast() {
      this.toast_control = false;
    }
  }

}
</script>
<style lang="scss">
section {
  .bg {
    width: 1200px;
    max-width: 100%;
    margin: 0 auto;
    .topBlock {
      text-align: center;
      position: relative;
      .turntable {
        min-height: 714px;
        position: relative; //转盘定位
        .turnPosition {
          // background: url(../assets/trTwo/pan02.png)
          //   no-repeat center center;
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          .conts {
            background: url(../assets/trTwo/pan02.png) center center no-repeat;
            background-size: 100%;
            padding: 8px;
            &::before {
              content: "";
              background: url(../assets/trTwo/roundLight01.png) center center
                no-repeat;
              background-size: 100%;
              position: absolute;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              animation: roundLight 0.8s linear infinite alternate;
            }
            &::after {
              content: "";
              background: url(../assets/trTwo/roundLight02.png) center center
                no-repeat;
              background-size: 100%;
              position: absolute;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              animation: roundLight 0.8s linear 0.8s infinite alternate;
            }
            .box {
              width: 14rem;
              height: 14rem;
              margin: auto;
              position: relative;
              // overflow: hidden;
              .pointerIcon {
                position: absolute;
                top: 0;
                left: 50%;
                z-index: 20;
                transform: translate(-50%, -50%);
              }
              .pointerBtn {
                width: 4.5rem;
                height: 4.5rem;
                position: absolute;
                top: 50%;
                left: 50%;
                z-index: 20;
                transform: translate(-50%, -50%);
                background: url(../assets/trTwo/pan05.png) top center no-repeat;
                background-size: 100%;
                transition: all 0.3s;
                filter: grayscale(1);
                cursor: default;
                &.cantrun {
                  cursor: pointer;
                  filter: grayscale(0);
                  &:hover {
                    transform: translate(-50%, -50%) scale(1.1);
                  }
                }

                p {
                  font-size: 0.36rem;
                  color: #fff;
                  font-weight: 700;
                  text-align: center;
                }
                p:first-of-type {
                  margin-top: 0.6rem;
                }
              }
              .boxbgFront {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) rotate(-30deg);
                z-index: 15;
                transition: all 0.1s;
                &.tranFront {
                  animation: tranFrontRotat 120s
                    cubic-bezier(0.07, 0.06, 0.19, 1);
                  // cubic-bezier(.19,.42,.28,1);
                }
              }
              .boxbg {
                width: 14rem;
                height: 14rem;
                background: url(../assets/trTwo/pan06.png) top center no-repeat;
                background-size: 100%;
                &.tran {
                  transition: transform cubic-bezier(0.09, 0.85, 0.19, 0.99);
                }
                .turn {
                  width: 14rem;
                  height: 14rem;
                  border-radius: 50%;
                  overflow: hidden;
                  .slice {
                    box-sizing: border-box;
                    border: 1px solid #ffd8ad;
                  }
                  .wheel-bg6 {
                    width: 100%;
                    height: 100%;
                    position: relative;
                    div {
                      text-align: center;
                    }
                    .prize-list {
                      width: 100%;
                      height: 100%;
                      position: absolute;
                      .prize-item {
                        // border:1px solid;
                        position: absolute;
                        top: 0;
                        z-index: 12;
                        width: 5rem;
                        height: 7rem;
                        left: 50%;
                        transform: translateX(-50%);
                        transform-origin: 0 100%;
                        .prize-name {
                          padding-top: 3.6rem;
                          font-size: 1.5rem;
                          color: #fff;
                        }
                      }
                    }
                  }
                }
              }
              .money {
                position: absolute;
                width: 0.57rem;
                height: 0.55rem;
                top: 2.17rem;
                right: -0.2rem;
              }
            }
            .prizebox {
              margin: 0.3rem;
              position: relative;
              border-radius: 4px;
              // overflow: hidden;
              padding: 0 0.27rem 0.28rem;
              .prizebg {
                position: absolute;
                border-radius: 4px;
                background: #fff;
                height: 100%;
                width: 100%;
                top: 0;
                left: 0;
                opacity: 0.2;
              }
              .pri {
                .titname {
                  color: #fff;
                  font-size: 0.32rem;
                  text-align: center;
                  margin: 0.07rem;
                  span {
                    img {
                      width: 1.51rem;
                      height: 0.14rem;
                      margin: 0 0.2rem 0.03rem;
                    }
                  }
                  .xuanz {
                    img {
                      transform: rotate(180deg);
                    }
                  }
                }
                .prizez {
                  width: 100%;
                  border: 1px solid #fa54a7;
                  border-radius: 4px;
                  background: #fff;
                  display: flex;
                  .couponleft {
                    padding-left: 0.3rem;
                    width: 3.9rem;
                    position: relative;
                    height: 100%;
                    .iconright {
                      div {
                        line-height: 1.1;
                      }
                      .couponname {
                        font-size: 0.32rem;
                        color: #333333;
                        margin: 0.45rem 0 0.2rem;
                      }
                      .timevalidity {
                        font-size: 0.24rem;
                        color: #999999;
                        margin-bottom: 0.2rem;
                      }
                      .timevalidity:last-of-type {
                        margin-bottom: 0.45rem;
                      }
                    }
                  }
                  .couponright {
                    flex: 1;
                    line-height: 1.2rem;
                    text-align: center;
                    font-size: 0.24rem;
                    color: #ff4745;
                    vertical-align: top;
                    position: relative;
                    .money {
                      position: relative;
                      bottom: 0.02rem;
                      margin-right: 0.02rem;
                    }
                    .moneynum {
                      font-size: 0.5rem;
                    }
                    a {
                      position: absolute;
                      left: 0;
                      right: 0;
                      bottom: 0.3rem;
                      width: 1.5rem;
                      height: 0.54rem;
                      color: #fff;
                      background: #ff4745;
                      border-radius: 2px;
                      line-height: 0.54rem;
                      text-align: center;
                      font-size: 0.28rem;
                      margin: auto;
                      display: block;
                    }
                    .tel {
                      bottom: 0;
                      top: 0;
                    }
                    div {
                      position: absolute;
                      right: -0.2rem;
                      top: 0;
                      bottom: 0;
                      margin: auto;
                      width: 1.28rem;
                      height: 1.28rem;
                      img {
                        width: 100%;
                        height: 100%;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      .timeBlock {
        font-size: 18px;
        position: relative;
        min-height: 166px;
        color: #fff;
        .timeArea {
          padding: 35px 0 0 90px;
          .activityTime,
          .countDown {
            display: inline-block;
            span {
              color: red;
            }
          }
        }
        .dowBtn {
          position: absolute;
          bottom: 10px;
          left: 50%;
          transform: translateX(-50%);
          cursor: pointer;
          width: 100px;
          height: 60px;
          > img {
            animation: mouse 1s infinite alternate;
          }
        }
        .linkBtn {
          position: absolute;
          top: 24px;
          right: 110px;
          cursor: pointer;
          .palink {
            cursor: pointer;
            display: block;
            transition: all 0.3s;
            &:hover {
              transform: scale(1.1);
            }
          }
        }
      }
    }
  }
  .popupBg {
    background-color: rgba(0, 0, 0, 0.6);
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;

    .popupBlock {
      background: url(../assets/trTwo/puBg.png) no-repeat center center;
      background-size: 100% 100%;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-60%, -50%);
      color: white;
      text-align: center;
      padding: 20px 40px;
      width: 400px;
      max-width: 100%;
      .puTitle {
        font-size: 18px;
        padding: 10px 0;
      }
      .puBlockA {
        > div {
          padding: 10px 0;
          > span {
            color: #fde405;
          }
        }
      }
      .puBtn {
        padding: 10px 0;
        .puClose,
        .pulinkBtn {
          display: inline-block;
          background: url(../assets/trTwo/puBtn.png) no-repeat center center;
          background-size: 100% 100%;
          color: #90070e;
          width: 120px;
          height: 56px;
          line-height: 56px;
          cursor: pointer;
        }
        .pulinkBtn {
          margin-left: 40px;
          .palink {
            color: #90070e;
            &:hover {
              color: #90070e;
            }
          }
        }
      }
    }
  }
  @keyframes roundLight {
    0%,
    40%,
    100% {
      opacity: 1;
    }

    60% {
      opacity: 0;
    }
  }
  @keyframes mouse {
    from {
      transform: translateY(0);
    }

    to {
      transform: translateY(100%);
    }
  }
  @keyframes tranFrontRotat {
    0% {
      transform: translate(-50%, -50%) rotate(-30deg);
    }
    100% {
      transform: translate(-50%, -50%) rotate(86400deg);
    }
  }
  @media screen and (max-width: 1020px) {
    section {
      .bg {
        .topBlock {
          padding-top: 3.8rem;
          .turntable {
            min-height: 356px;
            .turnPosition {
              transform: translate(-50%, -50%);
              margin-left: 0;
              .conts {
                .box {
                  width: 13rem;
                  height: 13rem;
                  .pointerIcon {
                    > img {
                      width: 80%;
                    }
                  }
                  .pointerBtn {
                    width: 4rem;
                    height: 4rem;
                  }
                  .boxbg {
                    width: 13rem;
                    height: 13rem;
                    .turn {
                      width: 13rem;
                      height: 13rem;
                      .wheel-bg6 {
                        .prize-list {
                          .prize-item {
                            width: 3.6rem;
                            height: 6.6rem;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          .timeBlock {
            font-size: 0.8rem;
            min-height: 5rem;
            padding-top: 0.6rem;
            .timeArea {
              background: url(../assets/trTwo/sa03.png) no-repeat center top;
              background-size: 100%;
              padding: 1.4rem 0 1.4rem 1rem;
            }
            .dowBtn {
              bottom: -1.2rem;
            }
            .linkBtn {
              top: -0.6rem;
              right: 6px;
              > img {
                width: 6rem;
              }
            }
          }
        }
      }
    }
  }
}
</style>

