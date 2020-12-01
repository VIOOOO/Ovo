import TYPES from './mutation-types'

export default {
    [TYPES.USER_INFO_INIT](state) {
        // return Object.assign({}, state.userInfo);
        // 以cookie为准        
        // const userInfo = keyValue2Json(cookie.getJSON('user'));
        // state.userInfo = userInfo;
        state.userInfo = {
            a:"1",
            b:"2",
        };
    },
    [TYPES.USER_INFO_SET](state, data) {
        delete data.gmpwd;
        // cookie.set('user', json2KeyValue(data), {
        //     path: '/'
        // });
        // cookie.set('authToken', data.authtoken, {
        //     path: '/'
        // });
        state.userInfo = data;
    },
    [TYPES.BANNER_SET](state, dataArray) {
        state.banners = dataArray;
    }
}