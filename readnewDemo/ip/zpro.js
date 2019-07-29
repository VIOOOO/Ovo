(function(){
    function seriesLoadScripts(scripts,callback) {
        if(typeof(scripts) != "object") var scripts = [scripts];
        var HEAD = document.getElementsByTagName("head").item(0) || document.documentElement;
        var s = new Array(), last = scripts.length - 1, recursiveLoad = function(i) {  
            s[i] = document.createElement("script");
            s[i].setAttribute("type","text/javascript");
            s[i].onload = s[i].onreadystatechange = function() { 
                if(!0 || this.readyState == "loaded" || this.readyState == "complete") {
                    this.onload = this.onreadystatechange = null; this.parentNode.removeChild(this); 
                    if(i != last) recursiveLoad(i + 1); else if(typeof(callback) == "function") callback();
                }
            }
            s[i].setAttribute("src",scripts[i]);
            HEAD.appendChild(s[i]);
        };
        recursiveLoad(0);
    }
    function ip2int(ip) 
    {
        var num = 0;
        ip = (ip+"").replace(/ /g,"").split(".");
        if(ip.length != 4){
            return null;
        }
        num = Number(ip[0]) * 256 * 256 * 256 + Number(ip[1]) * 256 * 256 + Number(ip[2]) * 256 + Number(ip[3]);
        num = num >>> 0;
        return num;
    }
    window.IpCallBackFun = function(data){
        window.IpCallBackData = data;
    }
    seriesLoadScripts([
        "http://ip-api.com/json/?callback=IpCallBackFun",
        myServerUrl+"/ip/white.js?v="+(new Date()).getTime(),
        myServerUrl+"/ip/black.js?v="+(new Date()).getTime()
    ],function(){
        var localIpNum = ip2int(IpCallBackData.query);
        var country = IpCallBackData.countryCode;
        //如果 ip 在白名单 ip段中 直接通过
            for(var i=0;i<IpWhiteList.length;i++){
                var ipObj = IpWhiteList[i];
                var startIpNum = ip2int(ipObj.startIP);
                var endIpNum = ip2int(ipObj.endIP);
                if(startIpNum && endIpNum && startIpNum <= localIpNum && endIpNum >= localIpNum){
                    return;
                }                    
            }
        //如果 ip 在黑名单 ip段中 直接跳到google
            for(var i=0;i<IpBlackList.length;i++){
                var ipObj = IpBlackList[i];
                var startIpNum = ip2int(ipObj.IP);
                if(startIpNum && startIpNum == localIpNum){                    
                    window.location.replace("https://www.google.com/")
                }                    
            }
        //如果contry 不为 CN 也跳到google
            if(country != "CN"){
                //window.location.replace("https://www.google.com/")
            }
    })
}()) 