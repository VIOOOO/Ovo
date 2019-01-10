<template>
  <div>
    <div id="rotary-table">
      <div class="award" v-for="(award,index) in awards" :class="['award'+index,{'active': index==current}]" :key="index">
        {{award.name}}
      </div>
      <div id="start-btn" @click="start">开始</div>
    </div>
    <div class="popBlock" v-if="popShow">
      <div class="pop">
        <p>中奖奖品为</p>
        <p v-if="award">{{award.id}}__{{award.name}}</p>
        <p class="closePop" @click="$_popShowEnt">关闭</p>
      </div>

    </div>
  </div>

</template>
<script>
export default {
  name: 'raffle',
  data() {
    return {
      current: 0,
      awards: [
        { id: 1, name: '空' },
        { id: 2, name: '眼镜' },
        { id: 3, name: '包' },
        { id: 4, name: '笨驴' },
        { id: 5, name: '书' },
        { id: 6, name: '手链' },
        { id: 7, name: '美女' },
        { id: 8, name: 'iphone' }
      ],
      speed: 200,
      diff: 15,
      award: {},
      time: 0,
      popShow: false, //中奖结果
      reserve: false //抽奖多转时间
    };
  },
  methods: {
    $_popShowEnt() {
      const that = this;
      that.popShow = false;
    },
    start() {
      // 开始抽奖
      this.drawAward();
      this.award = {}; //初始化中奖结果
      this.time = Date.now();
      this.speed = 300;
      this.diff = 15;
    },
    drawAward() {
      // 请求接口, 这里我就模拟请求后的数据(请求时间为2s)
      setTimeout(() => {
        let winnum = null;
        winnum = Math.floor(Math.random() * Number(this.awards.length - 1));//测试
        console.log(this.awards[winnum]);
        this.award = this.awards[winnum];
      }, 2000);

      //让转盘多转动时间
      setTimeout(() => {
        this.reserve = true;
      }, 6000);

      this.move();
    },
    move() {
      window.timeout = setTimeout(() => {
        this.current++;
        if (this.current > 7) {
          this.current = 0;
        }
        if (this.reserve && this.award.id && (Date.now() - this.time) / 1000 > 2) {
          let df = this.diff * 2
          this.speed += df; //减速
          if (this.speed >= 400) { //当速度降低后才会有弹窗结果
            if ((Date.now() - this.time) / 1000 > 4 && this.award.id == this.awards[this.current].id) {
              clearTimeout(window.timeout);
              setTimeout(() => {
                //   alert('恭喜你，抽中了' + this.award.name);
                this.popShow = true;
              }, 600);
              return;
            }
          }

        } else {
          if (this.speed >= 50) { //限制加速速度最大 ，值越小越快
            this.speed -= this.diff; //加速
          }
        }

        // console.log( this.speed );
        this.move();

      }, this.speed);
    }
  }
};
</script>

<style rel="stylesheet/less" lang="less">
* {
  margin: 0;
  padding: 0;
  list-style: none;
  outline: none;
}

#rotary-table {
  width: 340px;
  height: 349px;
  position: relative;
  margin: auto;
  background-color: antiquewhite;

  .award {
    width: 90px;
    height: 96px;
    line-height: 96px;
    text-align: center;
    float: left;
    position: absolute;
    overflow: hidden;
    background-color: aquamarine;

    &.active {
      background-color: darkgoldenrod;
    }

    &.award0 {
      top: 21px;
      left: 21px;
    }
    &.award1 {
      top: 21px;
      left: 125px;
    }
    &.award2 {
      top: 21px;
      right: 22px;
    }
    &.award3 {
      top: 126px;
      right: 22px;
    }
    &.award4 {
      bottom: 22.5px;
      right: 22px;
    }
    &.award5 {
      bottom: 22.5px;
      right: 125.5px;
    }
    &.award6 {
      bottom: 22.5px;
      left: 21px;
    }
    &.award7 {
      top: 126px;
      left: 21px;
    }
  }
  #start-btn {
    position: absolute;
    top: 125px;
    left: 124px;
    width: 90px;
    height: 96px;
    line-height: 90px;
    text-align: center;
    background-color: coral;
  }
}
.popBlock {
  background-color: rgba(0, 0, 0, 0.8);
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
.pop {
  background-color: #ffec72;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 500px;
  height: 400px;
  text-align: center;
  font-size: 30px;
  padding: 40px;
}
.closePop {
  padding-top: 60px;
  cursor: pointer;
}
</style>