//
//  DemoUser.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DemoProfileData;

@interface DemoUser : NSObject
/**
 * 用户id
 */
@property (nonatomic, copy)   NSString *uid;
/**
 * 用户头像地址
 */
@property (nonatomic, copy)   NSString *headUrl;
/**
 * 用户昵称
 */
@property (nonatomic, copy)   NSString *nickname;
/**
 * 用户性别
 * true女   false 男
 */
@property (nonatomic, assign) BOOL gender;
/**
 * 登录令牌
 */
@property (nonatomic, copy)   NSString *token;

+ (instancetype)shared;

/**
 * 登录成功后调用
 */
- (void)configeWithUser:(DemoUser *)user;

/**
 * 登录过的用户，重新启动App后，再次拉取个人信息后调用
 */
- (void)configeWithProfileData:(DemoProfileData *)profile;

- (void)loginOut;

@end
