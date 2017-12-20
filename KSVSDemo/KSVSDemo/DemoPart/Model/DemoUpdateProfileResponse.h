//
//  DemoUpdateProfileResponse.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoResponse.h"

@interface DemoUpdateProfileData : NSObject

@property (nonatomic, copy)   NSString *headUrl;

@property (nonatomic, copy)   NSString *nickname;

@property (nonatomic, assign) DemoGender *gender;

@end

@interface DemoUpdateProfileResponse : DemoResponse

@property (nonatomic, strong) DemoUpdateProfileData *data;

@end
