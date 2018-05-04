<template>
    <div>
        <div>
            <p>倒计时</p>
            <p>
                <slot>
                    {{content}}
                </slot>
            </p>
            <div class="cartoonTime">
                <div class="cartoonchile">
                    <transition name="cartoondd">
                        <div class="cartoonTimeLis" :key="dd">{{dd}}</div>
                    </transition>
                    :
                    <transition name="cartoonhh">
                        <div class="cartoonTimeLis" :key="hh">{{hh}}</div>
                    </transition>
                    :
                    <transition name="cartoonmm">
                        <div class="cartoonTimeLis" :key="mm">{{mm}}</div>
                    </transition>
                    :
                    <transition name="cartoonss">
                        <div class="cartoonTimeLis" :key="ss">{{ss}}</div>
                    </transition>
                </div>

            </div>
        </div>
        <div class="problem" v-for="ite in problemsLis" :key="ite.dateProblem" v-if="ite.dateProblem==dataOptfilter">
            <div>
                <P>题目抽奖</P>
                <div>
                    <p>
                        <span>{{ite.dateProblem}}</span> 问题:
                    </p>
                    <p>{{ite.problem}}</p>
                </div>
                <div>
                    <p>回答：{{problemsLisKey}}</p>
                    <ul class="answer">
                        <li class="answerList" v-for="(it,index) in ite.answerLis" :key="index">
                            <label><input type="radio" v-model="problemsLisKey" :value="it">{{it}}</label>
                        </li>
                    </ul>
                    <p class="answerBtn">
                        <span class="bt" @click="questionAnswering">确定</span>
                    </p>
                    <p>{{achievement}}</p>
                </div>
            </div>
        </div>
    </div>

</template>
<script>
import moment from 'moment';
export default {
    data() {
        const problemsLis = [
            {
                dateProblem: "4月25日",
                problem: "老方扛着黄幌子，老黄扛着方幌子。老方要拿老黄的方幌子，老黄要拿老方的黄幌子，末了儿方幌子碰破了黄幌子，黄幌子碰破了方幌子。",
                answerLis: ["A.老方", "B.老黄", "C.幌子", "D.碰破"],
                rightKey: "C.幌子"
            },
            {
                dateProblem: "4月26日",
                problem: "山上五棵树，架上五壶醋，林中五只鹿，箱里五条裤。伐了山上树，搬下架上的醋，射死林中的鹿，取出箱中的裤。",
                answerLis: ["A.五棵树", "B.五只鹿", "C.五壶醋", "D.林中的鹿"],
                rightKey: "C.五壶醋"
            },
            {
                dateProblem: "4月27日",
                problem: "粉红墙上画凤凰，凤凰画在粉红墙。 红凤凰、粉凤凰，红粉凤凰、花凤凰。 红凤凰,黄凤凰,红粉凤凰,粉红凤凰,花粉花凤凰。",
                answerLis: ["A.凤凰", "B.粉红墙", "C.粉凤凰", "D.红粉凤凰"],
                rightKey: "A.凤凰"
            },
            // {
            //     dateProblem: "",
            //     problem: "",
            //     answer: "",
            //     rightKey: ""
            // },
            // {
            //     dateProblem: "",
            //     problem: "",
            //     answer: "",
            //     rightKey: ""
            // },
        ]
        return {
            content: '',
            content2: '',
            dd: "",
            hh: "",
            mm: "",
            ss: "",
            endTime: "2018-04-26 14:59:59",
            endText: "活动结束",
            problemsLis,
            problemsLisKey: "",
            problemsrightKey: "",
            achievement: ""
        }
    },
    mounted() {
        this.countdowm(this.endTime)
    },
    computed: {
        timess() {
            let oldtimes = new Date("2018-05-14 12:00:00").getTime();
            let newTimes = new Date(oldtimes);
            return oldtimes + "----" + newTimes
        },
        dataOptfilter() {
            const that = this;
            let problemToday = moment().format('M月D日');
            // problemToday = "4月26日"
            that.problemsLis.forEach((element, index) => {
                if (element.dateProblem == problemToday) {
                    that.problemsrightKey = element.rightKey
                }
            });
            return problemToday
        }
    },
    methods: {
        countdowm(timestamp) {
            let that = this;
            let timer = setInterval(function () {
                let nowTime = new Date();
                let endTime = new Date(timestamp);
                let t = endTime.getTime() - nowTime.getTime();
                if (t > 0) {
                    let day = Math.floor(t / 86400000);
                    let hour = Math.floor((t / 3600000) % 24);
                    let min = Math.floor((t / 60000) % 60);
                    let sec = Math.floor((t / 1000) % 60);
                    day = day < 10 ? "0" + day : day;
                    hour = hour < 10 ? "0" + hour : hour;
                    min = min < 10 ? "0" + min : min;
                    sec = sec < 10 ? "0" + sec : sec;
                    let format = '';
                    if (day > 0) {
                        format = `${day}天${hour}小时${min}分${sec}秒`;
                        that.dd = day;
                        that.hh = hour;
                        that.mm = min;
                        that.ss = sec;
                    }
                    if (day <= 0 && hour > 0) {
                        format = `${hour}小时${min}分${sec}秒`;
                        that.dd = day;
                        that.hh = hour;
                        that.mm = min;
                        that.ss = sec;
                    }
                    if (day <= 0 && hour <= 0) {
                        format = `${min}分${sec}秒`;
                        that.dd = day;
                        that.hh = hour;
                        that.mm = min;
                        that.ss = sec;
                    }
                    that.content = format;

                } else {
                    clearInterval(timer);
                    that.content = that.endText;

                }
            }, 1000);
        },
        questionAnswering() {
            const that = this;
            // return that.problemsLisKey == "" ? true : false;
            if (that.problemsLisKey == "") return;
            that.problemsrightKey == that.problemsLisKey ? that.achievement = "正确" : that.achievement = "错误";

        }

    }
}
</script>
<style lang="scss" scoped>
.cartoonTime {
  padding: 30px 0 0 30px;
  .cartoonchile {
    position: relative;
    .cartoonTimeLis {
      display: inline-block;
      background-color: rgb(0, 0, 0);
      color: #fff;
      padding: 10px 6px;
      text-align: center;
    }
  }
}
.cartoondd-enter-active,
.cartoonhh-enter-active,
.cartoonmm-enter-active,
.cartoonss-enter-active {
  transition: all 0.8s;
  transform: translateY(-150%);
  position: absolute;
  opacity: 0.8;
}
.cartoondd-enter-active {
  left: 0;
}
.cartoonhh-enter-active {
  left: 44px;
}
.cartoonmm-enter-active {
  left: 88px;
}
.cartoonss-enter-active {
  left: 132px;
}
.cartoondd-leave-active,
.cartoonhh-leave-active,
.cartoonmm-leave-active,
.cartoonss-leave-active {
  transition: all 0.7s;
}
.cartoondd-enter-to,
.cartoonhh-enter-to,
.cartoonmm-enter-to,
.cartoonss-enter-to {
  transform: translateY(0);
  opacity: 1;
}
.cartoondd-leave-to,
.cartoonhh-leave-to,
.cartoonmm-leave-to,
.cartoonss-leave-to {
  opacity: 1;
}
.problem {
  width: 350px;
  margin: 0 auto;
  .answer {
    list-style-type: none;
    white-space: nowrap;
    .answerList + .answerList {
      padding-left: 20px;
    }
    .answerList {
      display: inline;
      //  letter-spacing: 1px;
      label {
        cursor: pointer;
      }
    }
  }
  .answerBtn {
    text-align: center;

    .bt {
      background-color: #ffc107;
      cursor: pointer;
      display: inline-block;
      padding: 4px 8px;
    }
  }
}
</style>