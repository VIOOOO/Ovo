import base from './base'

class EventGetReport extends base {

  request(jsonArg) {
    super.request({
      url: '/api/EventGetReport',
      data: jsonArg
    })
  }

  response(data) {
    return super.response(data,super.redirctJSON)
  }
}

export default EventGetReport
