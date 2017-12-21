//
//  KSVSPlayerViewController.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/16.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KSVSPlayerFrom) {
    KSVSPlayerFromPersonalCenter,
    KSVSPlayerFromSquareRecommend
};

@class KSVSVideoModel;

@interface KSVSPlayerViewController : UIViewController

/**
 * @abstract 出始化播放页视图控制器
 * @param videoModel 视频对象模型
 * @param playerFrom 是否是从个人中心push的
 */
- (instancetype)initWithVideoModel:(KSVSVideoModel *)videoModel
                        playerFrom:(KSVSPlayerFrom)playerFrom;

@end
