## [https抓包的详细步骤](http://www.jianshu.com/p/a9ad840e8f9a)

[01.jpeg]()

### Mac系统下https抓包

打开应用后， 我们要先安装证书。

Help -> SSL Proxying -> Install Charles Root Certficate

[02.jpeg]()

---
在弹出的钥匙串管理里面，刚安装的证书是不被信任的，我们要手动先信任下。

[03.jpeg]()

---
电脑的证书安装好后，我们要给手机进行证书的安装。

[04.jpeg]()

[05.jpeg]()

按照提示，打开手机里的 设置 -> WiFi-> WiFi详情页 下面的 http代理，选择到手动，并且按照提示设置值（每台电脑都不一样）

服务器:192.168.4.102

端口:8888

[06.jpeg]()

---
打开手机浏览器在地址栏中输入 http://charlesproxy.com/getssl

一路 同意&安装 最后会是这样子

[07.jpeg]()


---
配置

离革命胜利只差一步了，需要配置下 charels的https抓包规则。 我们选择全部抓包。

[08.jpeg]()

[09.jpeg]()

---
然后我们就可以看到 https 请求的内容了。

[10.jpeg]()

---

### Android 流程都一样。就是在浏览器输完证书地址后，证书一般在 设置->高级设置->安全和隐私->信任的凭据 中可以看到。

[11.jpeg]()


