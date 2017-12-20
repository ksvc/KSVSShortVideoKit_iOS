//
//  DemoCacheLoginMsg.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoCacheLoginMsg.h"
#import "NSObject+YYModel.h"
#import "DemoUser.h"

@interface DemoCacheLoginMsg ()

@end

@implementation DemoCacheLoginMsg

+ (void)cacheLoginedUserMsg:(DemoUser *)user {
    if (user) {
        [[NSUserDefaults standardUserDefaults] setValue:[user modelToJSONObject] forKey:kUserCacheKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (DemoUser *)loginedUserMsg {
    DemoUser *user = [DemoUser modelWithJSON:[[NSUserDefaults standardUserDefaults] objectForKey:kUserCacheKey]];
    return user;
}

+ (void)loginOutHandler {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [kCurrUser loginOut];
}

@end
