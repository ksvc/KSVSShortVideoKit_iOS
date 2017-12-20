//
//  KSVSAuthService.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/21.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSVSError;

@interface KSVSAuthService : NSObject

/**
 * 鉴权接口
 * @param bundleIdentifier bundle identifier
 * @param ksvsToken KSVSDk鉴权所需的token
 * @param accessToken 用户服务器下发的token
 * @param success 请求鉴权信息成功后的回调
 * @param failure 请求鉴权信息失败后的回调
 */
+ (void)authWithBundleIdentifier:(NSString *)bundleIdentifier
                       ksvsToken:(NSString *)ksvsToken
                     accessToken:(NSString *)accessToken
                         success:(void(^)(void))success
                         failure:(void(^)(KSVSError *ksvsError))failure;

@end
