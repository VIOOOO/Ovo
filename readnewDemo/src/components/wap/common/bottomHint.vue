<template>
  <section class="bottomHint" v-show="showBottomMsg">
    <p class="hint" v-show="showBottomMsg">
      已经到底啦~
    </p>
  </section>

</template>

<script>
export default {
  props: ['orientate'],
  // 传入值可以是，该元素的父元素 class ID
  data() {
    return {
      showBottomMsg: false,
      hintsetT: 0,
      anchorPoint: "" //定位顶部位置
    };
  },
  created() {
    const that = this;
    that.anchorPoint = that.orientate ? $local.vm.$f7.view.main.selector + ' ' + that.orientate : $local.vm.$f7.view.main.selector + ' .page-current .page-content'

    that.$nextTick(() => {
      let bo = document.querySelector(that.anchorPoint);
      // console.log(bo)
      const event = bo.onscroll;
      bo.onscroll = function () {
        if (event) {
          //判断是否有其他组件都绑定了onscroll，如果有则执行，避免互相覆盖
          event();
        }
        that.hintsetTA = document.querySelector(that.anchorPoint).scrollTop
        that.hintsetTB = document.querySelector(that.anchorPoint).scrollHeight
        that.hintsetTC = document.querySelector(that.anchorPoint).clientHeight
        let longH = (that.hintsetTB - that.hintsetTA - 100) <= that.hintsetTC;
        let shortH = (that.hintsetTB - 20) >= that.hintsetTC;
        if (longH && shortH) {
          that.showBottomMsg = true;
        } else {
          that.showBottomMsg = false;
        }
      };
    })
  },
  computed: {

  },
  methods: {
  }
};
</script>
<style lang="scss" scoped>
@import "../../../style/mixin";
.bottomHint {
  padding: 0.2rem 0 0;
  height: 30px;
  .hint {
    text-align: center;
  }
}
</style>

