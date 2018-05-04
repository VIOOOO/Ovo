import corefetch from '../../config/fetch'
import {
	getStore
} from '../../config/mUtils'

class base {


	/**
	 * 构造函数
	 * @param {*} jsonArg 
	 */
	constructor(jsonArg = {}) {
		const that = this;

		that.request(jsonArg)

		return new Promise(function (resolve, reject) {
			corefetch(that.url, that.data, that.type, that.method).then(function (data) {
				if (data.Passed) {
					resolve(that.response(data))
				} else {
					reject(data);
				}
			}, reject)
		});
	}

	/**
	 * request 请求，子函数可继承重写
	 * @param {*} jsonArg 
	 */
	request(jsonArg) {
		this.url = jsonArg.url;
		this.data = jsonArg.data;
		this.type = jsonArg.type || 'POST';
		this.method = jsonArg.method || 'not fetch';
	}

	/**
	 * response 格式化，子函数可继承重写
	 * @param {*} data 
	 * @param {*} format 
	 */
	response(data, format = this.fieldDataToArray) {
		const formatData = format(data.Data);
		console.log(formatData)
		return formatData;
    }


	/**
	 * format
	 * @param {*} d 
	 */
	fieldDataToArray(d) {
		var data = (Object.prototype.toString.call(d) === "[object String]") ? JSON.parse(d) : d,
			r = [],
			fields = data.Fields,
			datas = data.Datas;
		for (var i = 0; i < datas.length; i++) {
			var t = {};
			for (var j = 0; j < fields.length; j++) {
				t[fields[j].toLowerCase()] = datas[i][j];
			}
			r.push(t);
		}
		return r;
	}


	/**
	 * format
	 * @param {*} d 
	 */
	keyValueArrayToObject(d) {
		var data = (Object.prototype.toString.call(d) === "[object String]") ? JSON.parse(d) : d,
			r = {};
		if (data instanceof Array) {
			for (let i = 0; i < data.length; i++) {
				let e = data[i]
				r[e.Key.toLowerCase()] = e.Value;
			}
			return r;
		} else {
			return data;
		}
	}


	/**
	 * format
	 * @param {*} d 
	 */
	redirctValue(d) {
		return d;
	}


	/**
	 * format
	 * EventCanJoinList、EventHasJoinList、EventApply
	 * @param [{"Passed":false,"FailedMessage":"不在活动时间!","Data":null},{"Passed":false,"FailedMessage":"event.notExists","Data":null},{"Passed":false,"FailedMessage":"不在活动时间","Data":null},{"Passed":false,"FailedMessage":"不在活动时间!","Data":null},{"Passed":false,"FailedMessage":"event.isClosed","Data":null},{"Passed":true,"FailedMessage":"","Data":"false"},{"Passed":false,"FailedMessage":"event.notExists","Data":null}] d 
	 */
	redirctJSON(d) {
		return (Object.prototype.toString.call(d) === "[object String]") ? JSON.parse(d) : d
	}
}

export default base
