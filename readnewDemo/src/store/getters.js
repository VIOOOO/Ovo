import state from './state'
import { clientContact } from '../config/env';
import md5 from 'md5'

export default {
    menuInfo: state => state.menuInfo,
    alert: state => state.alert,
    CustomAlertTip:state => state.CustomAlertTip,
    // UserInfo:state => state.UserInfo,
    clientContact: state => {
        if(state.config.CustomerChat2 == '0'){
            return `javascript:LC_API.show_full_view();`
        }
        else if(state.config.CustomerChat2 == '1'){
            if (state.userInfo) {
                /** 旧客服参数 */
                //return clientContact + `&enterurl=${location.hostname}&s=1&info=userId%3D${state.userInfo.username}%26name%3D${state.userInfo.username}-${state.userInfo.truename}`;
                /** 新客服参数 */
                const key = 'uuDJ80000' ;//这个需要在客服系统中配置，写死的
                const timestamp = Date.parse(new Date());
                const hashCode = md5(encodeURIComponent(`${state.userInfo.username}${state.userInfo.username}${state.userInfo.isvip}${state.userInfo.username+'-'+state.userInfo.truename}${timestamp}${key}`).toUpperCase()).toUpperCase()
                return clientContact + `&info=userId%3D${state.userInfo.username}%26loginname%3D${state.userInfo.username}%26grade%3D${state.userInfo.isvip}%26name%3D${state.userInfo.username+'-'+state.userInfo.truename}%26timestamp%3D${timestamp}%26hashCode%3D${hashCode}`;
                
            }
            else {
                return clientContact;
            }
        }
    }
}





