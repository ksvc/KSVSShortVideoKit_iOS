//
//  KSVSReleasedVideoResponse.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "KSVSRespons.h"
#import "KSVSVideoModel.h"

@interface KSVSReleasedVideoData : NSObject
@property (nonatomic, copy) NSNumber *Size;
@property (nonatomic, copy) NSNumber *Page;
@property (nonatomic, copy) NSNumber *TotalPages;  //页总量（待定）
@property (nonatomic, copy) NSNumber *TotalCount;  //数据总量（待定）
@property (nonatomic, copy) NSArray<KSVSVideoModel*> *Videos;
@end

@interface KSVSReleasedVideoResponse : KSVSRespons
@property (nonatomic, strong) KSVSReleasedVideoData *Data;
@end
