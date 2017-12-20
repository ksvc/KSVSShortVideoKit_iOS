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
 最短录制时长, 视频集合的总时长必须大于该值，默认为5s
 */
@property (nonatomic, assign) NSTimeInterval minRecDuration;
/**
 最长录制时长，视频集合的总时长必须小于该值，当录制时长超过该值后内部自动停止录制, 默认sdk本身不限制，但必须大于minRecDuration
 */
@property (nonatomic, assign) NSTimeInterval maxRecDuration;

- (instancetype)initWithUserId:(NSString *)userId
                      userName:(NSString *)userName
                    userAvatar:(NSString *)userAvatar;

- (instancetype)initWithUserId:(NSString *)userId;

- (BOOL)timingRecord;

@end
