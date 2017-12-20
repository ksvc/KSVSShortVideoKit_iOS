//
//  DemoActionSheet.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoActionSheet : UIActionSheet

@property (nonatomic, copy) void(^actionSheetBlock)(NSInteger buttonIndex);

@end
