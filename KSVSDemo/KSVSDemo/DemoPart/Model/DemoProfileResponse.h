//
//  DemoProfileResponse.h
//  KSVSDemo
//
//  Created by devcdl on 2017/12/7.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoResponse.h"

@interface DemoProfileData : NSObject

@property (nonatomic, copy)   NSString *uid;

@property (nonatomic, copy)   NSString *headUrl;

@property (nonatomic, copy)   NSString *nickname;

/**
 * 性别
 * trure 女， false男
 */
@property (nonatomic, assign) BOOL gender;

@end

@interface DemoProfileResponse : DemoResponse

@property (nonatomic, strong) DemoProfileData *data;

@end
