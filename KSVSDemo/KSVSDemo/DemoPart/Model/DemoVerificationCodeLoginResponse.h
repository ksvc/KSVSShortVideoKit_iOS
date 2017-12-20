//
//  DemoVerificationCodeLoginResponse.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoResponse.h"

@class DemoUser;

/**
 * 手机验证码登录的响应
 */
@interface DemoVerificationCodeLoginResponse : DemoResponse

@property (nonatomic, strong) DemoUser *data;

@end
