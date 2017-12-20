//
//  KSVSUserInfoRequestService.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 用户个人信息相关网络服务
 */
@class KSVSReleasedVideoResponse;
@class KSVSDeleteReleasedVideoResponse;
@class KSVSUploadConfigeResponse;
@class KSVSError;

@interface KSVSUserInfoRequestService : NSObject

/**
 * @abstract 获取已发布视频列表
 * @param userId 用户id
 * @param page 第几页的数据
 * @param size 每页最多返回数据条数
 * @param completion 请求完成回调
 */
+ (void)fetchReleasedVideoWithUserId:(NSString *)userId
                                page:(NSInteger)page
                                size:(NSInteger)size
                          completion:(void(^)(KSVSReleasedVideoResponse *response ,KSVSError *ksvsError))completion;

+ (void)deleteReleasedVideoWithUserId:(NSString *)userId
                              videoId:(NSString *)videoId
                           completion:(void(^)(KSVSDeleteReleasedVideoResponse *response ,KSVSError *ksvsError))completion;

+ (void)fetchUploadConfigWithUserId:(NSString *)userId
                      completion:(void(^)(KSVSUploadConfigeResponse *response, KSVSError *ksvsError))completion;

@end
