import {isApp,serverUrl} from '@/config/env'

export default {

    beforePromise(p) {
        //param.a=4
        //console.log(this)
    },
    beforeAxios(p) {
        // param.a = {
        //     b: 2
        // }
        // return false;
        if(p.axios){
            p.axios.baseURL = serverUrl;
        }
    },
    afterAxios(p) {
        p.data = p.data.Data;
    },
    beforeVuex(p) {

    },
    afterVuex(p) {

    }
}