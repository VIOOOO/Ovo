<template>
  <section class="setTop-block" v-show="showSetUP">
    <!-- wap返回顶部图标 -->
    <transition name="fade">
      <div v-show="showSetUP" class="setTop">
        <img @click="$_backToTopArrowClick" :src="setTop01" title="返回顶部" alt="返回顶部">
        <!-- <span>{{setT}}</span> -->
      </div>
    </transition>

  </section>
</template>

<script>
import { buildImg } from "@/config/env";
import { mapGetters, mapActions } from "vuex";
import TYPES from "@/store/mutation-types";

export default {
  props: ['orientate'],
  // 传入值可以是，该元素的父元素 class ID
  data() {
    return {
      setTop01: buildImg(require("@/assets/wap/images/common/setTop01.png")),
      showSetUP: false,
      setT: 0,
      anchorPoint: "" //定位顶部位置

    };
  },
  created() {
    const that = this;
    that.anchorPoint = that.orientate ? $local.vm.$f7.view.main.selector + ' ' + that.orientate : $local.vm.$f7.view.main.selector + ' .page-current .page-content'
    // 注意 class 之间的空格不能少

    /**
    * 监听置顶图标显示
    */
    that.$nextTick(() => {
      let p = document.querySelector(that.anchorPoint);
      const event = p.onscroll;
      p.onscroll = function () {
        if(event){
           //判断是否有其他组件都绑定了onscroll，如果有则执行，避免互相覆盖
          event();
        }
        that.setT = document.querySelector(that.anchorPoint).scrollTop
        if (that.setT < 200) {
          that.showSetUP = false;
        } else {
          that.showSetUP = true;
        }
      };
    })

  },
  computed: {

  },
  methods: {

    $_backToTopArrowClick() {
      const that = this;
      let oldSet = that.setT;
      const time = setInterval(() => {
        if (oldSet > 600) {
          oldSet = oldSet - 120;
        } else {
          oldSet = oldSet - 30;
        }
        if (oldSet < 10) {
          clearTimeout(time);
        }
        document.querySelector(that.anchorPoint).scrollTop = oldSet;
      }, 1);
    }
  },
  watch: {

  }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.setTop-block {
  position: fixed;
  right: 10px;
  bottom: 80px;
  width: 40px;
  height: 40px;
  z-index: $zindex_regular;
  .setTop {
    width: 100%;
    height: 100%;
    > img {
      width: 100%;
      transition: all 0.3s 3s;
      &:hover {
        transform: scale(1.2);
      }
    }
  }
  .fade-enter-active,
  .fade-leave-active {
    transition: all 0.5s;
  }
  .fade-enter,
  .fade-leave-to {
    opacity: 0;
  }
}
</style>