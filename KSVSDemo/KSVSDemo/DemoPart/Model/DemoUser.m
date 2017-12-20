//
//  DemoUser.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoUser.h"
#import "DemoProfileResponse.h"

static DemoUser * currentUser = nil;

@implementation DemoUser

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentUser = [[self alloc] init];
    });
    return currentUser;
}

- (void)configeWithUser:(DemoUser *)user {
    self.uid = user.uid;
    self.headUrl = user.headUrl;
    self.nickname = user.nickname;
    self.gender = user.gender;
    self.token = user.token;
}

- (void)configeWithProfileData:(DemoProfileData *)profile {
    self.uid = profile.uid;
    self.headUrl = profile.headUrl;
    self.nickname = profile.nickname;
    self.gender = profile.gender;
}


- (void)loginOut {
    self.uid = nil;
    self.headUrl = nil;
    self.nickname = nil;
    self.token = nil;
}

@end
