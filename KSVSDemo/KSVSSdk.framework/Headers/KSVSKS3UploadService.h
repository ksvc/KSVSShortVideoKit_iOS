//
//  KSVSKS3UploadService.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage, KSVSError;

@interface KSVSKS3UploadService : NSObject

/**
 * @abstract 初始化上传对象
 * @param userId 当前用户的id
 */
- (instancetype)initWithUserId:(NSString *)userId;

/**
 * @abstract 上传头像
 * @param headImage 相册或拍照选取的图片
 * @param success 上传成功的回调，headImageUrl为头像在ks3上的地址（例如，上传成功后修改imageView.image为headImage）
 * @param failure 上传失败的回调
 */
- (void)uploadHeadImage:(UIImage *)headImage
                success:(void(^)(NSString *headImageUrl))success
                failure:(void(^)(KSVSError *ksvsError))failure;

/**
 * @abstract 上传视频
 * @param localVideoPath 本地视频地址
 * @param progress 上传视频的进度（0 ~ 1）
 * @param success 上传成功的回调，remoteVideoPath为所上传视频在ks3上的地址
 * @param failure 上传失败的回调
 */
- (void)uploadVideo:(NSString *)localVideoPath
           progress:(void(^)(float progressValue))progress
            success:(void(^)(NSString *remoteVideoPath))success
            failure:(void(^)(KSVSError *ksvsError))failure;

@end
