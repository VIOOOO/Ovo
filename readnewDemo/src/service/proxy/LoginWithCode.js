import base from './base'

class LoginWithCode extends base {

	request(jsonArg) {
		super.request({
			url: '/api/User/LoginWithCode?input='+jsonArg.input+'&code='+jsonArg.code,
		})
	}

}

export default LoginWithCode
