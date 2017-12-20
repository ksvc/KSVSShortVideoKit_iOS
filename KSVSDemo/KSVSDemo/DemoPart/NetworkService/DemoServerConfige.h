//
//  DemoServerConfige.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#ifndef DemoServerConfige_h
#define DemoServerConfige_h

#define DEMO_RELEASE

/***** Server Confige  *******/

#ifdef DEMO_RELEASE
#define DEMO_SERVER_HOST (@"https://kms-svsdk-demo-api.ksyun.com")
#define DEMO_DOMAIN  (@"kms-svsdk-demo-api.ksyun.com")
#else
#define DEMO_SERVER_HOST (@"http://kms-svsdk-demo.api.seancloud.cn")
#define DEMO_DOMAIN  (@"kms-svsdk-demo.api.seancloud.cn")
#endif

/********** Request Path ************/
/**
 * 获取手机验证码
 */
static NSString * const kFetchMobileVerCodePath = @"/api/v1/mobile/code/send";
/**
 * 验证码登录
 */
static NSString * const kMobileVerCodeLoginPath = @"/api/v1/mobile/code/check";
/**
 * 退出登录
 */
static NSString * const kLoginOutPath = @"/api/v1/logout";
/**
 * 修改个人信息
 */
static NSString * const kUpdateProfiletPath = @"/api/v1/user/info/update";
/**
 * 获取个人信息
 */
static NSString * const kFetchProfiletPath = @"/api/v1/user/info";

#endif /* DemoServerConfige_h */
