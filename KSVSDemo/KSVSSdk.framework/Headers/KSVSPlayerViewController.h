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

- (instancetype)initWithVideoModel:(KSVSVideoModel *)videoModel
                        playerFrom:(KSVSPlayerFrom)playerFrom;

@end
