<template>
  <div class="index-wrap">
    <h2>轮播组件1</h2>
    <slide-show :slides="slides"></slide-show>
    <h2>轮播组件2</h2>
    <enters-to class="ent" :slides="slides"></enters-to>
    <div class="cls"></div>
    <div class="tes3">
      <div> 
        <div class="showScroll">
          {{showScrollTop}}
        </div>
      </div>
      <div>
        <countdown></countdown>
      </div>

    </div>
  </div>
</template>

<script>
// import service from "./service";
import slideShow from "./components/slideShow";
import entersTo from "./components/entersTo";
import countdown from "./components/countdown";

export default {
  components: {
    slideShow,
    entersTo,
    countdown
  },
  data() {
    return {
      slides: [
        {
          href: "#1",
          src: require("./assets/1.jpg"),
          title: "xxx1"
        },
        {
          href: "#2",
          src: require("./assets/2.jpg"),
          title: "xxx2"
        },
        {
          href: "#3",
          src: require("./assets/3.jpg"),
          title: "xxx3"
        },
        {
          href: "#4",
          src: require("./assets/4.jpg"),
          title: "xxx4"
        },
        {
          href: "#5",
          src: require("./assets/5.jpg"),
          title: "xxx5"
        }
      ],
      items: [], //获取后端数据 存放
      showScrollTop: 0,

    };
  },
  watch: {

  },
  created() { //获取后端数据
    const that = this;
    // new service.getBanner().then(function (data) {
    //   that.items = data;
    // });

  },
  computed: {
    endTimeMum() {
      let tt = new Date("2018-04-23 23:59:59")
      return tt.getTime();
    }
  },
  methods: {

  },
  mounted() {
    const that = this;
    window.onscroll = function () {
      let t = document.documentElement.scrollTop || document.body.scrollTop;
      that.showScrollTop = t;
    };
  }
};
</script>

<style lang="scss" scoped>
@import "./assets/style";
.index-wrap {
  overflow: hidden;
  h2 {
    text-align: center;
    margin-top: 50px;
  }
  .transitionGu,
  .ent {
    width: 700px;
    height: 400px;
    margin: 0 auto;
  }
  .cls {
    height: 200px;
    margin-bottom: 300px;
  }
  .tes3 {
    background-color: palevioletred;
    height: 800px;
    margin-bottom: 100px;
    .showScroll {
      background-color: palegoldenrod;
      position: fixed;
      bottom: 10%;
      right: 10%;
      width: 200px;
      height: 150px;
      padding-top: 50px;
      text-align: center;
    }
  }
}
</style>
