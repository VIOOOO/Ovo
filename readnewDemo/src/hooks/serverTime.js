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
        // delete data.Passed
        // data = data.Data
        //p.data = JSON.parse(p.data.Data);
        try{
            p.data = new Date(p.data);
        }catch(e){
            p.data = new Date();
        }
    },
    beforeVuex(p) {

    },
    afterVuex(p) {

    }
}