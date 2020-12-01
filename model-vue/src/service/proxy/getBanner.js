import base from './base'

class getBanner extends base {

  request(jsonArg) {
    super.request({
      url: '/api/GetPageBanner?contentId=WEB.BANNER',
      type: 'POST',
    })
  }

  response(data) {
    return super.response(data)
  }
}

export default getBanner
