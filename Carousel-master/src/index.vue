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
        <section style="height:200px;width:100%；">

  <div class="toolbar tabbar toolbar-bottom">
    <div class="toolbar-inner">
      <a href="#tab-1" class="tab-link tab-link-active">Tab 1</a>
      <a href="#tab-2" class="tab-link">Tab 2</a>
      <a href="#tab-3" class="tab-link">Tab 3</a>
    </div>
  </div>
  <div class="tabs-swipeable-wrap">
    <div class="tabs">
      <div id="tab-1" class="page-content tab tab-active">
        <div class="block">
          <p>Tab 1 content</p>
          ...
        </div>
      </div>
      <div id="tab-2" class="page-content tab">
        <div class="block">
          <p>Tab 2 content</p>
          ...
        </div>
      </div>
      <div id="tab-3" class="page-content tab">
        <div class="block">
          <p>Tab 3 content</p>
          ...
        </div>
      </div>
    </div>
  </div>

        </section>
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
            xmlList: `<request currency="cny" startTimestamp="1552290049" execInterval="600" casino="luckydragon88" info="2">
                        <casinodata timestamp="1552290234" winc="6897" casino="luckydragon88">
                        <amount-list>
                        <amount pos="0" sign="CNY" step="23.00" wins="884019.01" currency="cny">192154540.91</amount>
                        </amount-list>
                        </casinodata>
                        <gamedata timestamp="1552290234" local="0" winc="0" gamegroup="abbj" game="abbj">...</gamedata>
                        <gamedata timestamp="1552290234" local="0" winc="1" gamegroup="adv" game="adv-1">...</gamedata>
                        <gamedata timestamp="1552290234" local="0" winc="0" gamegroup="adv" game="adv-2">...</gamedata>
                        <gamedata timestamp="1552290234" local="0" winc="0" gamegroup="adv" game="adv-3">...</gamedata>
                        <gamedata timestamp="1552290234" local="0" winc="0" gamegroup="ashabw" game="ashabw-1">...</gamedata>
                        </request>`
        };
    },
    watch: {

    },
    created() { //获取后端数据
        const that = this;
        // new service.getBanner().then(function (data) {
        //   that.items = data;
        // });
        that.$_xmls();

    },
    computed: {
        endTimeMum() {
            let tt = new Date("2018-04-23 23:59:59")
            return tt.getTime();
        }
    },
    methods: {
        $_xmls() {
            var jsonObj = this.$x2js.xml2js(this.xmlList);
            console.log(jsonObj)
        }

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
