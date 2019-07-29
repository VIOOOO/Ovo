<template>
    <div v-if="CustomAlertTip.show">
        <div class="dialog-backdrop backdrop-in"></div>
        <div class="alertBOX">
          <div class="TopButton">
              <span class="rightbtn" v-if="CustomAlertTip.ok" @click="CustomAlertTip.success">{{CustomAlertTip.oktext || '确定'}}</span>
              <span class="leftbtn" v-if="CustomAlertTip.close" @click="close">关闭</span>
          </div>
          <div class="contetnWrap">
            <div class="searchInput">
              <div class="search">
                    <input type="text" v-model="SearchValue" placeholder="请输入内容" > 
                    <i></i>
              </div>
            </div>
            <div class="footerAlert">
              <i class="icon iconfont icon-gantanhao--"> </i> <em>{{CustomAlertTip.content}}</em>
            </div>
          </div>
        </div>
    </div>
</template>

<script>
import TYPES from "@/store/mutation-types";
import { mapGetters, mapActions } from "vuex";
export default {
  data(){
      return {
        SearchValue:""
      }
  },
  computed: mapGetters(["CustomAlertTip"]),
  methods: {
    close() {
      if (this.CustomAlertTip.close) {
          this.$store.commit(TYPES.CUSTOMALERTTIP, {
            show: false,
            title: "提示",
            content: "",
            width: 340,
            height: 60,
            ok: false,
            oktext: "",
            success: () => {},
            close: true
          });
      }
    }
  },
  created() {
    
  },
  watch:{
      'CustomAlertTip.show'(newVal){
          if(newVal===true){
            const that = this;
            let oldSuccess = null;
            this.$store.commit(TYPES.CUSTOMALERTTIP,{"Value":""})
            if(toString.call(that.CustomAlertTip.success)=="[object Function]"){
                oldSuccess=that.CustomAlertTip.success;
            }
            this.$store.commit(TYPES.CUSTOMALERTTIP, {
                success: () => {
                    if(oldSuccess){
                        this.$store.commit(TYPES.CUSTOMALERTTIP,{"Value":that.SearchValue})
                        this.SearchValue="";
                        oldSuccess();
                    }
                    that.close();
                }
            });
          }
      }
  }
};
</script>

<style lang="scss" scoped>
@import "../../../style/mixin";
.alertBOX{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  z-index: 10000000000;
  width: 90%;
  text-align: center;
  padding-bottom:30%;
  background: #ffffff;
  border-radius: 0.4rem;
  .TopButton{
    height: 1.5rem;
    position: relative;
    border-bottom: 1px solid #dadada;
    font-size: 0.55rem;
    .leftbtn{
      position: absolute;
      top: 0.35rem;
      left: 0.6rem;
    }
    .rightbtn{
      position: absolute;
      top: 0.35rem;
      right: 0.6rem;
      color: #ffc641;
    }
  }
  .contetnWrap{
    position: absolute;
    top: 1.5rem;
    width: 90%;
    left: 5%;
    .searchInput{
        padding:1.25rem 0 0.45rem;
        .search{
            position: relative;
            input{
              width: 100%;
              height: 1.75rem;
              line-height: 1.75rems;
              border: 1px solid #dadada;
              border-radius: 0.2rem;
              padding: 0.25rem;
            }
        }
    }
    .footerAlert{
      text-align: left;
      .icon-gantanhao--{
        color: red;
      }
      em{
        color: #909090;
        font-style: normal;
      }
    }

  }
}
</style>




