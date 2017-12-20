//
//  DemoCacheLoginMsg.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DemoUser;

@interface DemoCacheLoginMsg : NSObject

+ (void)cacheLoginedUserMsg:(DemoUser *)user;

+ (DemoUser *)loginedUserMsg;

+ (void)loginOutHandler;

@end
