//
//  DemoNavigationBar.h
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/11/14.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoUser;

@interface DemoNavigationBar : UIView

- (instancetype)initWithUser:(DemoUser *)user
                 recordBlock:(void(^)(void))recordBlock;

- (instancetype)initWithUser:(DemoUser *)user
                 recordBlock:(void(^)(void))recordBlock
            avatarClickBlock:(void(^)(void))avatarClickBlock;

- (void)updateBarData;

@end
