import base from './base'

class MemberLogin extends base {

    request(jsonArg) {
        super.request({
            url: '/api/MemberLogin',
            type: 'POST',
            data: jsonArg
        })
    }

    response(data) {
        return super.response(data, super.keyValueArrayToObject)
    }
}

export default MemberLogin
