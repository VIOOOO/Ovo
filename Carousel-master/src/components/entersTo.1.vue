<template>
  <section class="entersto">
    <ul class='slide-ul' @mouseover="clearT" @mouseout="timeout">
      <li>
        <a v-if="slides.length" :href="slides[indexNow].href">
          <transition :name='tr'>
            <!--必须设置name,放入其中的元素能够过度-->
            <img :src='src' :key='indexNow'>
            <!--当src改变了，这张图就消失了，满足类似v-if的渲染条件。必须设置key值，因为都是img元素，不设置会只改变图片，不进行切换-->
          </transition>
        </a>
      </li>
    </ul>
    <div class="slide-button-prev" @click='last'></div>
    <div class="slide-button-next" @click='next'></div>
    <!-- 获取到的数组数量大于1才让圆点显示 -->
    <ul class='slide-pages' v-show="slides.length>1">
      <!--这儿放圆点，数量对应数组的值，并且绑定click，-->
      <li v-for="(item, index) in slides" @mouseover='change(index)' :class="{on:index===indexNow}" :key="index"></li>
    </ul>
    <!--当index==n（当前显示元素的索引）的时候，圆点变为红色-->
  </section>
</template>
<script>
export default {
  props: {
    slides: {
      type: Array,
      default: []
    }
  },
  data() {
    //如果是普通页，需该为data：{}
    return {
      n: 0, //图片的index。
      tr: "tr1", //trnsition 标签的name值，我写了2套css方案，因为你点下一张，它往左运动，点上一张它往右运动。
      timeout1: "", //这是flag定时器的数据
      timeout2: "", //这是自动播放（next（））定时器的数据
      timeout3: "", //这是打开浏览器时，初始运动定时器的数据
      flag: true,
      indexNow: 0,
      inv: {
        // 定时器
        type: Number,
        default: 2000
      }
    };
  },
  methods: {
    next() {
      // console.log(this.slides.length);
      //下一张
      if (this.flag) {
        //为了避免连续点击。让flag运动结束后再变为true。
        this.flag = false;
        this.clearT(); //运动之前，清除所有定时器。
        this.n = this.n + 1 == this.slides.length ? 0 : this.n + 1; //下一张，如果是最后一张，就返回第一张。
        this.tr = "tr1"; //css方案切换到tr1，就是transition的name属性变为tr1。
        this.timeout(); //调用timeout函数，其作用是等待下一次轮播，调整flag，以便可以点击切换。
      }
    },
    last() {
      //上一张，跟next方向相反
      if (this.flag) {
        this.flag = false;
        this.clearT();
        // this.n = this.n - 1 == 0 ? 7 : this.n - 1; //当它变为第1张时，下一张就是第7张。
        this.n = this.n - 1 == -1 ? this.slides.length - 1 : this.n - 1;
        this.tr = "tr2"; //切换css方案2
        this.timeout();
      }
    },
    clearT() {
      //清除所有定时器。
      clearTimeout(this.timeout1);
      clearTimeout(this.timeout2);
      clearTimeout(this.timeout3);
    },
    timeout() {
      //运动结束后设置flag为true，并且过3秒调用next，进行下一次运动。
      this.timeout2 = setTimeout(() => {
        this.flag = true;
      }, 600); //运动时间是1s。
      this.timeout1 = setTimeout(() => {
        this.next();
      }, this.inv.default);
    },
    change(index) {
      //点击小黑点，切换到那一张，需要将这一个圆点的index传下来。
      if (this.flag) {
        this.flag = false;
        this.clearT();
        this.tr = index - this.n > 0 ? "tr1" : "tr2"; //看选择css1方案还是css2方案。
        this.n = index; //将显示那一张变为选中的那一张。
        this.timeout();
      }
    }
  },
  computed: {
    src() {
      this.indexNow = this.n; // 保留当前索引值，对应小圆点获取 class
      return this.slides[this.n].src; //地址，this.n与图片编号对应。
    }
  },
  mounted() {
    this.timeout3 = setTimeout(this.next, this.inv.default); //刚挂载dom，就开始等待进行第一次轮播，
  }
};
</script>
<style lang="scss" scoped>
//css
//杂项布局 可忽略
* {
  margin: 0;
  padding: 0;
}
.entersto {
  position: relative;
  height: 100%;
  width: 100%;
  overflow: hidden;
  li {
    list-style: none;
    position: relative; //设置为相对位置。
  }
  .slide-ul {
    width: 100%;
    height: 100%;
    margin: 0 auto;
    overflow: hidden;
    &:hover .slide-button-prev {
      opacity: 1;
    }
    &:hover .slide-button-next {
      opacity: 1;
    }
    li {
      width: 100%;
      height: 100%;
      img {
        width: 100%;
        height: 100%;
        margin: 0 auto;
        display: inline-block;
        position: absolute; //设置绝对定位
      }
    }
  }
  .slide-button-prev,
  .slide-button-next {
    position: absolute;
    top: 40%;
    width: 54px;
    height: 54px;
    cursor: pointer;
    z-index: 10;
    opacity: 0;
  }
  .slide-button-prev {
    left: 0;
    background-image: url("../assets/slideShow/05_Default---left.png");
  }
  .slide-button-prev:hover {
    background-image: url("../assets/slideShow/06_Hover---left.png");
    opacity: 1;
    background-position: 1px 0%;
  }
  .slide-button-next {
    right: 0;
    background-image: url("../assets/slideShow/01_Default---right.png");
  }
  .slide-button-next:hover {
    background-image: url("../assets/slideShow/02_Hover---right.png");
    opacity: 1;
  }
  .slide-pages {
    position: absolute;
    top: 380px;
    left:38%;
    z-index: 10;
    width: 100%;
    margin: 0 auto;
    text-align: center;
    font-size: 0;
    list-style: none;
    li {
      float: left;
      height: 6px;
      width: 30px;
      margin: 0 3px;
      background-color: #b2b2b2;
    }
    li.on {
       background-color: palevioletred;
    }
  }
}

//方案一 让图片从右往左运动。

.tr1-enter {
  // opacity: 0;
  left: 100%; //从左边开始进入。
}
.tr1-enter-to {
  left: 0; //过度到正常位置，必须写，position定位不写，会是默认位置，可能不是left:0这儿。
  transition: all 1s; //过度一秒
  // opacity: 1;
}
.tr1-leave {
  //离开动画
  left: 0;
  // opacity: 1;
}
.tr1-leave-to {
  transition: all 1s;
  // opacity: 0;
  left: -100%//正常位置过度到左边，然后消失。;
}

//方案二：与方案一方向是反的，其他全部相同。
.tr2-enter {
  // opacity: 0;
  left: -100%;
}
.tr2-enter-to {
  left: 0;
  transition: all 1s;
  // opacity: 1;
}
.tr2-leave {
  left: 0;
  // opacity: 1;
}
.tr2-leave-to {
  transition: all 1s;
  // opacity: 0;
  left: 100%;
}
</style>



