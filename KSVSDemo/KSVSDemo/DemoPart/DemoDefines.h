//
//  DemoDefines.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#ifndef DemoDefines_h
#define DemoDefines_h
#import <Foundation/Foundation.h>
#import "DemoServerConfige.h"

typedef NS_ENUM(NSInteger, DemoGender) {
    DemoGenderMale = 0,
    DemoGenderFemale
};

#define kCurrUser ([DemoUser shared])

#define DEMO_BUNDLEID ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])

#define DEMO_SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)

/**
 * 用于KSVSDK 鉴权的token，由金山云颁发给客户
 */
#ifdef DEMO_RELEASE
#define DEMO_TOKEN @"ff9737a56f0805482b1dff8fb662c784"
#else
#define DEMO_TOKEN @"123b808763ebb21576c4345b8944d7a6"
#endif


//#define DEMO_TOKEN @"b96f022b410cb20e695e7650535899eb"

/**
 * 登录时请求使用此token，登录后请求使用登录返回的token
 */
static NSString * const kDemoAuthToken = @"AKLTAkF1cPsvQsyn3DFZSxLBaf";
/**
 * 登录时用于签名计算的一个字符串，登录后换成登录返回的token
 */
static NSString * const kDemoAuthKey = @"ON8XoXxgwQ/WHgxKvKzkdryPs54AcK2NN/B/zzFMLgTawTv823lbjcnvSv/5Z3OC3w==";

static NSString * const kDemoLoginToken = @"demoLoginToken";

static NSString * const kUserCacheKey = @"kUserCacheKey";



/******* 通知 ********/
static NSString * const kDemoLoginTokenExpiredNotification = @"kDemoLoginTokenExpiredNotification";

/***** 展示文案  *****/
static NSString * const kNoNetworkString = @"当前网络不可用";

#endif /* DemoDefines_h */
