
import {isApp,serverUrl} from '@/config/env'
export default {    
    beforeAxios(p) {
        if(p.axios){
            p.axios.baseURL = serverUrl;
        }
    },
    afterAxios(p) {
        if(p.data.Passed){
            p.data = fieldDataToArray(p.data.Data)
        }
    },
}

function fieldDataToArray(d) {
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