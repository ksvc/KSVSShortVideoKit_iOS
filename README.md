# 金山云短视频解决方案 KSVSShortVideo_iOS


## 1 简述
短视频解决方案专为客户提供端到云到端的一站式解决方案。集视频采集、编辑、上传、转码、存储、智能推荐算法、播放SDK等于一体的真正意义上的一站式SAAS级解决方案。

短视频SDK提供了视频采集，实时美颜，专业滤镜，支持视频画面比例裁剪，支持断点续拍，录制变速，多视频导入等功能。

短视频服务也支持定制化，用户自行定制UI和界面，充分与业务整合，实现业务的快速发展。
金山云短视频服务，以重运营，轻研发的服务理念，让您避免复杂的架构设计和编程开发，极大地降低技术对接成本。
![image1](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/01.png)![image2](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/02.png)![image3](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/03.png)


## 2 项目架构
短视频解决方案架构图如下:

![image](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/7.png)
### 2.1 架构流程描述
* APP 集成时，需要先鉴权才能使用短视频解决方案后续功能
* 短视频解决方案包含推荐页、播放页、录制页等等特别漂亮绚丽的展示效果
* 解决方案也包含上传头像、查询删除已上传视频等接口
* 解决方案借助于短视频SDK、金山云存储等实现短视频录制、编辑、上传、播放等功能
* 短视频解决方案有一个高大上的视频推荐算法，为每个用户推荐喜爱的视频

### 2.2 鉴权流程
短视频解决方案有一个更加安全、合理的鉴权方案，保证APP以及用户数据的安全。具体的鉴权流程如下：
1. 申请SDK Token并且调用SDK提供的鉴权接口
2. APP 向解决方案提供User Token，可以增加二次鉴权逻辑。(注:User Token 可以不提供)
3. 解决方案向SDK Server 验证SDK Token是否正确
4. SDK Server 向APP Server验证User Token 是否正确

鉴权流程图解如下：

![image](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/auth.png)

### 2.3 高大上的推荐算法
短视频解决方案提供完整的推荐算法，可以让每个用户都能看到自己喜爱的视频。推荐算法准确性相关因素：
1. 点赞信息
2. 播放记录
3. 用户上传视频时，视频名称、视频标签等对点赞都有影响

## 3 功能介绍
* **短视频SDK**

* [x]  实时美颜：支持录制时，开启关闭美颜效果
* [x]  实时滤镜：支持录制时添加滤镜效果
* [x]  定时拍：录制时延迟拍摄
* [x]  闪光灯：
* [x]  变焦：
* [x]  对焦、爆光度
* [x]  摄像头切换
* [x]  断点续拍、回删：支持断点拍摄及任意一段视频的删除
* [x]  单视频导入
* [x]  视频裁剪：支持视频时长裁剪,支持视频画面比例裁剪，支持填充和裁剪两种模式
* [x]  实时音乐
* [x]  音量调节：支持原声、背景音乐调整，支持静音处理
* [x]  录制变速：录制时支持变速功能，支持音乐变速功能
* [x]  滤镜：支持编辑时添加滤镜效果
* [x]  自定义时长：支持自定义设置最短和最长录制时长

* **金山云存储**

* **金山云转码**

* **智能推荐**

## 4 接入流程

### 4.1 申请流程
1. 若购买短视频解决方案套餐包，需进入[金山云短视频解决方案官网](https://www.ksyun.com/post/solution/KSVS)，点击“购买套餐包”，确认购买，填写表单信息，授权token会以邮件的形式提供。
2. 若单独购买短视频SDK，联系金山云销售进行授权申请，或者直接拨打：62927777 转 5120

### 4.2 集成流程
1. 从github克隆KSVSShortVideoKit_iOS工程，进入KSVSDemo目录下，用Xcode打开KSVSDemo.xcworkspace，将Frameworks目录下的KSVSSdk拖进自己的工程中

```
github 地址：https://github.com/ksvc/KSVSShortVideoKit_iOS.git
```

1. 通过cocoapods依赖其他相关项目

```
pod 'KSYMediaEditorKit', '~> 1.6.1'

pod 'Masonry'
pod 'MBProgressHUD'
pod 'YYKit'
pod 'SVProgressHUD'
pod 'AFNetworking', '~> 3.0'
pod 'VTMagic'
pod 'FMDB'
pod 'ICGVideoTrimmer'
pod 'UITextView+Placeholder', '~> 1.2'
pod 'MJRefresh'
pod 'UICKeyChainStore'
pod 'Toast', '~> 4.0.0'

```

1. 具体的接口使用，请在WIKI查看：[wiki](https://github.com/ksvc/KSVSShortVideoKit_iOS/wiki)

## 5 反馈与建议
### 5.1 反馈模版
|类型|描述|
|:--:|:--:|
|SDK名称    |KSVSShortVideoKit_iOS|
|SDK版本    |v1.0.0|
|设备型号    |iPhone 6|
|OS版本    |iOS8|
|问题描述    |描述问题出现的现象|
|操作描述    |描述经过如何操作出现上述问题|
|额外附件|文本形式控制台log、crash报告、其他辅助信息（界面截屏或录像等）|
### 5.2 短视频解决方案咨询
金山云官方产品客服，帮您快速了解对接金山云短视频解决方案：

![image](https://raw.githubusercontent.com/wiki/ksvc/KSVSShortVideoKit_Android/images/wechat.png)
### 5.3 联系方式
* 主页：[金山云](http://www.ksyun.com/)
* 邮箱: zengfanping@kingsoft.com
* QQ讨论群：
* 574179720 视频云技术交流群
* 621137661 视频云iOS技术交流
* 以上两个加一个QQ群即可
* Issues: https://github.com/ksvc/KSVSShortVideoKit_iOS/issues

