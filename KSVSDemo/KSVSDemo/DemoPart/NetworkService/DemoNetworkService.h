//
//  DemoNetworkService.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoVerificationCodeResponse.h"
#import "DemoVerificationCodeLoginResponse.h"
#import "DemoLoginOutResponse.h"
#import "DemoUpdateProfileResponse.h"
#import "DemoProfileResponse.h"

@interface DemoNetworkService : NSObject

+ (void)fetchVerificationCodeWithMobile:(NSString *)mobile
                               complete:(void(^)(DemoVerificationCodeResponse *response, DemoError *demoError))complete;
/**
 * 获取个人信息
 */
+ (void)fetchProfileWithComplete:(void(^)(DemoProfileResponse *response, DemoError *demoError))complete;

+ (void)loginWithMobile:(NSString *)mobile
                verCode:(NSString *)verCode
               complete:(void(^)(DemoVerificationCodeLoginResponse *response, DemoError *demoError))complete;

+ (void)loginOutComplete:(void(^)(DemoLoginOutResponse *response, DemoError *demoError))complete;

+ (void)updateProfileWithHeadUrlPath:(NSString *)headUrlPath
                       nickname:(NSString *)nickname
                         gender:(BOOL)gender
                       complete:(void(^)(DemoUpdateProfileResponse *response, DemoError *demoError))complete;

@end
