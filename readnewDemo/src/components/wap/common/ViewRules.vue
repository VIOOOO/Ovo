<template>
    <div v-if="alert.show">
        <div class="dialog-backdrop backdrop-in"></div>
        <div class="dialog dialog-buttons-2 modal-in" style="display: block; margin-top: -71px;">
          <div class="dialog-inner">
            <div class="dialog-title">{{alert.title}}</div>
            <div class="dialog-text" v-html="alert.content"></div>
          </div>
          
          <div class="dialog-buttons">
            
              <span class="dialog-button dialog-button-bold" v-if="alert.ok" @click="alert.success">{{alert.oktext || '确定'}}</span>

              <span class="dialog-button" v-if="alert.close" @click="close">关闭</span>
            
          </div>
        
        </div>
    </div>
</template>

<script>
import TYPES from "@/store/mutation-types";
import { mapGetters, mapActions } from "vuex";
export default {
  computed: mapGetters(["alert"]),
  methods: {
    close() {
      if (this.alert.close) {
          this.$store.commit(TYPES.ALERT_TIP, {
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
    this.$store.commit(TYPES.ALERT_TIP,{"name":"jon"})
  },
  
  watch:{
      'alert.show'(newVal){
          if(newVal===true){
            const that = this;
            let oldSuccess = null;
            if(toString.call(that.alert.success)=="[object Function]"){
                oldSuccess=that.alert.success;
            }
            this.$store.commit(TYPES.ALERT_TIP, {
                success: () => {
                    if(oldSuccess){
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
.alert-tip {
  z-index: $zindex_high;
  @include fixed_center();
  margin-top: -100px;
  border: 5px solid $white_smoke;
  background: $gray_dim;
  .alert-header {
    padding: 6px;
    @include sc($font_big, $white);
    background: $red_deep;
    .alert-close {
      font-size: $font_small;
      border-radius: 50%;
      float: right;
      background: $gray;
      opacity: 0.6;
      height: 18px;
      width: 18px;
      text-align: center;
      cursor: pointer;
    }
    .alert-close:hover {
      opacity: 1;
    }
  }
  .alert-content {
    padding: 20px;
    text-align: center;
    @include sc($font_regular,$white);
  }
  .alert-footer {
    padding-bottom: 10px;
    text-align: center;
    .alertChoice,
    .alertClose {
      background: $white;
      display: inline-block;
      padding: 8px 10px;
      text-align: center;
      min-width: 90px;
      opacity: 0.8;
      &:hover {
        opacity: 1;
      }
    }
    .alertChoice {
      color: $white;
      border: 1px solid $blue;
      background: $gray_dark;
      &:hover {
        background: $red_deep;
      }
    }
    .alertClose {
      color: $black;
    }
  }
}
.alert-mask {
  z-index: 998;
  background: rgba(0, 0, 0, 0.6);
  @include fixed_center();
  @include wh(100%,100%);
}
</style>


