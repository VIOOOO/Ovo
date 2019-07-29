<template> 
    <f7-toolbar class="toolbar-bottom-md" tabbar labels>
      <f7-link v-for="(item,index) in tabList" :key="index"  :class="[item.icon,{'cur':index==indexVal}]" @click="eventClick(item,index)" :text="item.text" tab-link="" :href="item.href">
      </f7-link>
    </f7-toolbar>
</template>

<script>
import { mapGetters } from "vuex";
import { isiOS } from "@/config/env";
export default {
  data() {
    const items = [
      {
        icon: "icon-home",
        text: "首页",
        href: "/Member/Home",
      },
      {
        icon: "icon-94",
        text: "分享",
        href: "/Member/PostIt",
      },
      {
        icon: "icon-wode",
        text: "我的",
        href: "/Member/MyCenter",
      }
    ];
    const loginItems=[
      {
        icon: "icon-home",
        text: "首页",
        href: "/Member/Home",
      },
      {
        icon: "icon-94",
        text: "分享",
        href: "/Member/PostIt",
      },

      {
        icon: "icon-wode",
        text: "我的",
        href: "/Member/MyCenter",
      }
    ];
    return {
      items,
      loginItems,
    };
  },
  created(){
  },
  computed:{
     ...mapGetters(["clientContact", "indexVal"]),
     tabList(){
       if(this.userInfo){
         return this.loginItems;
       }
       else{
         return this.items;
       }
     }
  },
  watch: {
  },
  methods: {
    eventClick(item, index) {
        this.$store.commit("indexVal", index);
        if (item.text == "客服") {
          if (isiOS) {
            window.jumpLink(`${this.clientContact}`,"_default",null,"PORTRAIT");
          } else {
            window.jumpLink(`${this.clientContact}`,"_system",null,"PORTRAIT");
          }
        }
    }
  }
};
</script>
<style lang="scss" scoped>
</style>



