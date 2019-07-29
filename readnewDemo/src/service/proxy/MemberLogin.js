import base from './base'
import { isApp, isWap, isPc, isAndroid } from '@/config/env'

class MemberLogin extends base {

    request(jsonArg) {

        if (isApp && (jsonArg instanceof Array) && device && device.uuid) {
            //添加设备、设备号
            jsonArg.push({
                key: "terminalType", value: JSON.stringify({
                    cordova: device.cordova,
                    model: device.model,
                    platform: device.platform,
                    uuid: device.uuid,
                    version: device.version,
                    manufacturer: device.manufacturer,
                    isvirtual:device.isVirtual,
                    serial:device.serial
                })
            })
            jsonArg.push({ key: "terminalIMEI", value: device.uuid })
        }

        if (isApp) {
            jsonArg.push({ key: "clientType", value: isAndroid ? 'ANDROID' : 'IOS' })
        }
        else if (isWap) {
            jsonArg.push({ key: "clientType", value: 'WAP' })
        }
        else {
            jsonArg.push({ key: "clientType", value: 'WEB' })
        }

        super.request({
            url: '/api/MemberLogin',
            data: jsonArg
        })
    }

    response(data) {
        return super.response(data, super.keyValueArrayToObject)
    }
}

export default MemberLogin
