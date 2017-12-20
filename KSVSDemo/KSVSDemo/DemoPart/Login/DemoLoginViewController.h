//
//  DemoLoginViewController.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/21.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoLoginViewController : UIViewController

- (instancetype)initWithLoginSuccessBlock:(void(^)(void))loginSuccessBlock;

@end
