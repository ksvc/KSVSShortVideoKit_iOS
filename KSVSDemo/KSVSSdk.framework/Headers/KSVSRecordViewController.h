//
//  KSVSRecordViewController.h
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/10/19.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "KSVSBaseViewController.h"

@interface KSVSRecordViewController : KSVSBaseViewController
    
/**
 * 最短录制时长, 视频集合的总时长必须大于该值，默认为5s
 */
@property (nonatomic, assign) NSTimeInterval minRecDuration;
/**
 * 最长录制时长，视频集合的总时长必须小于该值，当录制时长超过该值后内部自动停止录制, 默认sdk本身不限制，但必须大于minRecDuration
 * 默认60s
 */
@property (nonatomic, assign) NSTimeInterval maxRecDuration;
/**
 * @abstract 初始化录制页视图控制器 （目前仅支持用push到此控制器）
 * @param userId 用户id (App Server返回的，可参考KSVSDemo部分)
 * @param userName 用户昵称 (App Server返回的，可参考KSVSDemo部分)
 * @param userAvatar 用户头像地址 (App Server返回的，可参考KSVSDemo部分)
 */
- (instancetype)initWithUserId:(NSString *)userId
                      userName:(NSString *)userName
                    userAvatar:(NSString *)userAvatar;

/**
 * @abstract 初始化录制页视图控制器（目前仅支持用push到此控制器）
 * @param userId 用户id (App Server返回的，可参考KSVSDemo部分)
 */
- (instancetype)initWithUserId:(NSString *)userId;

// 此方法不用关心
- (BOOL)timingRecord;

@end
