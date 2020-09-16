[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/wangchunin/v2ray)  
  
> 提醒： 滥用可能导致账户被BAN！！！  

TIPS:
* Heroku部署v2ray,添加了caddy和tor的支持，部署后点击View，成功应显示caddy欢迎页面 

* 客户端使用vless websockets tls方式链接服务端  
    默认UUID: `8f91b6a0-e8ee-11ea-adc1-0242ac120002`  websocket默认路径: `/`  
  
* 可在部署时修改变量UUID和WSPATH，服务端和客户端需相同  
  
* 可以搭配clouflare cdn使用，[参考IBMYes项目的这里](https://github.com/CCChieh/IBMYes#cloudflare-%E9%AB%98%E9%80%9F%E8%8A%82%E7%82%B9%E4%B8%AD%E8%BD%AC)，修改`url.hostname`为**app**分配到的`xxxxxxxxx.herokuapp.com`  
  
* 部署到kintohub: https://github.com/mixool/v2ray/tree/master/kinto
