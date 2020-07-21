# iOSWeatherAPP



---




## 1. 项目简介

这是一款用Swift 5编写的简易的iOS天气APP，主要实现了`定位获取本地天气`、`根据城市名搜索天气`这两个功能。另外，该APP中还有通过API获取数据时的加载动画。

项目使用CocoaPods管理第三方库。这些库包括Alamofire、SwiftyJSON、NVActivityIndicatorView。

开发工具：Xcode 11.5

开发语言：Swift 5

目标系统：iOS 13.5



<div align=center>
<img src="https://img-blog.csdnimg.cn/20200721144642892.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>

---


### 1.1 功能与参数

`定位获取本地天气`功能通过[OpenWeatherMap](https://openweathermap.org/)提供的API<font color=gray size=2>（该API免费版提供的数据中没有空气指数等信息）</font>来实现，传入URL中的参数是本设备的经纬度。

`根据城市名搜索天气`功能通过[天气API](https://www.tianqiapi.com/)来实现<font color=gray size=2>（该API免费版的参数中不能传入经纬度）</font>，搜索框输入的中文城市名<font color=gray size=2>（如：成都）</font>。



软件界面中的参数有：

1. 城市名称、星期几、天气图标、天气类型、当前温度、湿度、气压<font color=gray size=2>（两个API均能获取）</font>
2. 空气指数、空气质量、外出建议、开窗建议<font color=gray size=2>（仅天气API能获取）</font>



---

### 1.2 效果图

1. 启动页面

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/20200721144630826.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


2. 打开软件后弹出获取定位的提示

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/20200721144641406.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


3. 加载动画

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/20200721145353281.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


4. 定位<font color=gray size=2>（国外 / 白天）</font>

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/20200721144642946.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


5. 定位<font color=gray size=2>（国外 / 夜晚）</font>

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/2020072114464135.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


6. 搜索<font color=gray size=2>（国内 / 空气质量好）</font>

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/20200721144640570.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


7. 搜索城市<font color=gray size=2>（国内 / 空气质量差）</font>

<div align=center>
<img width="30%" src="https://img-blog.csdnimg.cn/202007211446411.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>





---



## 2. 运行方法

 

1. 将[OpenWeatherMap](https://home.openweathermap.org/users/sign_in)账户中的`API_KEY`，[天气API](http://www.tianqiapi.com/user)账户中的`APPID`、`APPSecret`粘贴到代码的相应位置上

<div align=center>
<img width="85%" src="https://img-blog.csdnimg.cn/20200721144635316.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


<div align=center>
<img width="85%" src="https://img-blog.csdnimg.cn/20200721144635305.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>



2. 模拟器选择`iPhone 11`以获得最好的显示效果，之后点击`运行`即可

<div align=center>
<img width="55%" src="https://img-blog.csdnimg.cn/20200721144637644.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>



<font color = salmon>**附：**</font>

1. 修改模拟器的经纬度

<div align=center>
<img width="70%" src="https://img-blog.csdnimg.cn/20200721144641830.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>


2. 经纬度参考

<div align=center>


| 地点   | 经度Longitude | 纬度Latitude |
| ------ | ------------- | ------------ |
| 伦敦   | 2.2           | 48.52        |
| 纽约   | -74.0         | 40.43        |
| 莫斯科 | 37.35         | 55.45        |
| 北京   | 39.92         | 116.42       |
| 成都   | 104.07        | 30.67        |

</div>


3. 测试API的URL获取数据时，可以使用`Rested`，它会将JSON数据以清晰的结构呈现出来。该软件可以在`App Store`获取。

<div align=center>
<img width="80%" src="https://img-blog.csdnimg.cn/20200721144639878.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1NoZXJsb29vY2s=,size_16,color_FFFFFF,t_70#pic_center">
</div>





---




## 3. 相关资源

### 3.1 API参考文档

* [天气API](http://www.tianqiapi.com/index/doc?version=v6)
* [OpenWeatherMap](https://openweathermap.org/current)



### 3.2 天气图标

* [图标库：天气  |  作者：欣雨](https://www.iconfont.cn/collections/detail?cid=6802)

* [图标库：ios12  |  图标名：天气  |  作者：奔跑的宇航员](https://www.iconfont.cn/collections/detail?spm=a313x.7781069.0.da5a778a4&cid=9958)

  

### 3.3 CocoaPods

 * [使用CocoaPods管理第三方库](https://blog.csdn.net/Sherlooock/article/details/107063947) 



---


如若项目运行报错`Command PhaseScriptExecution failed with a nonzero exit code`，可尝试从CSDN下载[项目压缩包](https://download.csdn.net/download/Sherlooock/12647041)


