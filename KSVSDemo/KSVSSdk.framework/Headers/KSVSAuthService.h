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
 * @abstract 鉴权接口
 * @param bundleIdentifier bundle identifier
 * @param ksvsToken KSVSDk鉴权所需的token(由金山云颁发，可参考https://github.com/ksvc/KSVSShortVideoKit_iOS申请流程)
 * @param accessToken App Server下发的token(登录App后，由App Server后返回的token，可参考KSVSDemo部分)
 * @param success 请求鉴权信息成功后的回调
 * @param failure 请求鉴权信息失败后的回调（KSVSError错误码参考KSVSErrorCodeDefines.h）
 */
+ (void)authWithBundleIdentifier:(NSString *)bundleIdentifier
                       ksvsToken:(NSString *)ksvsToken
                     accessToken:(NSString *)accessToken
                         success:(void(^)(void))success
                         failure:(void(^)(KSVSError *ksvsError))failure;

/**
 * @abstract 获取鉴权状态（YES:已鉴权，NO:未鉴权）
 */
+ (BOOL)authState;

/**
 * @abstract 清除本地鉴权信息
 */
+ (BOOL)clearAuthInfo;

@end
