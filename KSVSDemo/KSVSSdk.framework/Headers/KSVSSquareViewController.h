//
//  KSVSSquareViewController.h
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/11/14.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "KSVSBaseViewController.h"

@interface KSVSSquareViewController : KSVSBaseViewController

/**
 * @abstract 初始化广场页控制器
 * @param userId App用户id(由App Server返回)
 */
- (instancetype)initWithUserId:(NSString *)userId;

- (instancetype)initWithUserId:(NSString *)userId
                      userName:(NSString *)userName
                       headUrl:(NSString *)headUrl
                      bundleId:(NSString *)bundleId;

@end
