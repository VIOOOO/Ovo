<template>
	<div class="mymusic">
		<type-list name="我的音乐" iconinfo="icon-musicfill" count="28" :playing="true"></type-list>
		<type-list name="最近播放" iconinfo="icon-video" count="18"></type-list>
		<type-list name="我的电台" iconinfo="icon-time" count="1"></type-list>
		<type-list name="我的收藏" iconinfo="icon-likefill" count="3" :has-border="false"></type-list>
		<musicsheet v-for="(ite,ind) in items" :key="ind" :itemqqq="ite" :indexqqq="ind"></musicsheet>
		底部显示的菜单列表
		<!-- <menu-list></menu-list> -->
	</div>
</template>

<script>
import musicsheet from "../musicsheet/musicsheet.vue";
import typelist from "./typelist/typelist.vue";
// import menulist from '../menulist/menulist.vue'
export default {
  computed: {
    items() {
      return this.$store.getters.getMusicAllList.sheets;
    }
  },
  components: {
    "type-list": typelist,
    musicsheet: musicsheet
    // 'menu-list': menulist
  },
  mounted() {
    //   console.log(JSON.stringify(this.$store.getters.getMusicAllList.sheets));
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="less">
@import "../../../static/font-icon/iconfont.css";
@import "../../common/common.less";
.mymusic {
  background: #fff;
  overflow: auto;
  margin-top: 50px;
  margin-bottom: 50px;
}
</style>
