import blank from '../components/blank'

var routerConfig = {
  mode: '',
  routes: [
   
  {
    path: '(.*)',
    needAuthencation: true,
    component: "",
},
  ]
}
/**
 * 合并活动路由
 */
routerConfig.routes = [...routerConfig.routes]

routerConfig.routes.forEach(function (r) {
  if (r.components && !r.components.header) {
    r.components.header = blank;
  }
  /**
   * @description 处理登录验证
   */
  if (r.needAuthencation) {
    r.beforeEnter = (to, from, next) => {
      setTimeout(() =>{
        if (!r.needAuthencation || $local.state.UserInfo) {
          next()
        } else {
          next('/CN/Login')
          // window.jumpLink("/CN/Login", '_router')
        }
        // ...
      },0)
      
    }
  }
})



/* 置顶 */
routerConfig.scrollBehavior = function (to, from, next) {
  /**
   * 前端页面都需要置顶
   */
  if (from.fullPath.toLowerCase() == '/' || from.fullPath.toLowerCase().includes('/cn/')) {
    return {
      x: 0,
      y: 0
    }
  }
}

if (process.env.MODE_NPM_CMD.includes('-android')) {
  delete routerConfig.mode;
}

try {
  setTimeout(() => {
    routerConfig.routes.forEach(a => {
      if (a.path != '/' && a.components) {
        for (let ckey in a.components) {
          /**
           * 排除不预加载组件
           * 1、header、footer：避免重复加载
           * 2、Allfishgames 因为内部有window.onscroll
           * 3、Deposit等不是异步加载的组件
           */
          if (!['header', 'footer'].includes(ckey) && Object.prototype.toString.call(a.components[ckey]) == "[object Function]") {
            if (!['Allfishgames'].includes(a.components[ckey].name)) {
              a.components[ckey].call();
            }
          }
        }
      }
    })
  }, 5000)
} catch (e) {

}

export default routerConfig;
