import base from './base'

class getBanner extends base {

  request(jsonArg) {
    super.request({
      url: '/api/GetPageContent?contentId=WEB.HOME.BANNER'
    })
  }

  response(data) {
    return super.response(data)
  }
}

export default getBanner