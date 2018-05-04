<template>
  <div class="slide-show" @mouseover="clearInv" @mouseout="runInv">
    <div class="slide-img">
      <a v-if="slides[nowIndex]" :href="slides[nowIndex].href">
        <transition name="slide-trans">
          <img v-if="isShow" :src="slides[nowIndex].src">
        </transition>
        <transition name="slide-trans-old">
          <img v-if="!isShow" :src="slides[nowIndex].src">
        </transition>
      </a>
    </div>
    <!-- <h2>{{ slides[nowIndex].title }}</h2> -->
    <div class="slide-button-prev" @click="goto(prevIndex)"></div>
    <div class="slide-button-next" @click="goto(nextIndex)"></div>
    <ul class="slide-pages">
      <!-- 两种 li 显示页码效果 -->
      <li v-for="(item, index) in slides" @click="goto(index)" :class="{on:index===nowIndex}" :key="index"></li>
      <!-- <li v-for="(item, index) in slides" @click="goto(index)" :key="index">
        <a :class="{on: index === nowIndex}">{{ index + 1 }}</a>
      </li> -->
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    slides: {
      type: Array,
      default: []
    },
    inv: {
      type: Number,
      default: 2000
    }
  },
  data() {
    return {
      nowIndex: 0,
      isShow: true
    };
  },
  computed: {
    prevIndex() {
      if (this.nowIndex === 0) {
        return this.slides.length - 1;
      } else {
        return this.nowIndex - 1;
      }
    },
    nextIndex() {
      if (this.slides.length === 0 ||this.nowIndex === this.slides.length - 1
      ) {
        return 0;
      } else {
        return this.nowIndex + 1;
      }
    }
  },
  methods: {
    goto(index) {
      this.isShow = false;
      setTimeout(() => {
        this.isShow = true;
        this.nowIndex = index;
      }, 10);
    },
    runInv() {
      this.invId = setInterval(() => {
        this.goto(this.nextIndex);
      }, this.inv);
      // console.log(this.slides); //查看获取数据
    },
    clearInv() {
      clearInterval(this.invId);
    }
  },
  mounted() {
    this.runInv();
  }
};
</script>

<style lang="scss" scoped>
.slide-trans-enter-active {
  transition: all 0.5s;
}
.slide-trans-enter {
  transform: translateX(100%);
}
.slide-trans-old-leave-active {
  transition: all 0.5s;
  transform: translateX(-100%);
}
.slide-show {
  position: relative;
  margin: 0 auto;
  width: 700px;
  height: 400px;
  overflow: hidden;
  border: 3px solid #333;
  .slide-img {
    width: 100%;
  }
  .slide-img img {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
  }
  .slide-show h2 {
    position: absolute;
    width: 100%;
    color: #fff;
    background: #000;
    opacity: 0.5;
    bottom: 0;
    margin: 0;
    height: 32px;
    padding-left: 15px;
  }
  .slide-button-prev,
  .slide-button-next {
    position: absolute;
    top: 40%;
    width: 54px;
    height: 54px;
    cursor: pointer;
  }
  .slide-button-prev {
    left: 0;
    background-image: url("../assets/slideShow/05_Default---left.png");
  }
  .slide-button-prev:hover {
    background-image: url("../assets/slideShow/06_Hover---left.png");
  }
  .slide-button-next {
    right: 0;
    background-image: url("../assets/slideShow/01_Default---right.png");
  }
  .slide-button-next:hover {
    background-image: url("../assets/slideShow/02_Hover---right.png");
  }
  .slide-pages {
    position: absolute;
    right: 10px;
    bottom: 20px;
    list-style: none;
    li {
      float: left;
      margin-right: 20px;
      margin-top: 12px;
    }
    li::after {
      content: "";
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 50%;
      border: 2px solid #fff;
      cursor: pointer;
    }
    li.on::after {
      background-color: deeppink;
    }
  }

  // li显示页码效果

  // .slide-pages {
  //   position: absolute;
  //   right: 10px;
  //   bottom: 20px;
  //   li {
  //     display: inline-block;
  //     padding: 0 10px;
  //     cursor: pointer;
  //     color: #fff;
  //     font-size: 16px;
  //   }
  //   li .on {
  //     color: deeppink;
  //     text-decoration: underline;
  //   }
  // }
}
</style>
