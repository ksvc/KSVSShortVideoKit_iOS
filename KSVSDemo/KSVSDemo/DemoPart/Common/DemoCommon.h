//
//  DemoCommon.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHAssetCollection;

@interface DemoCommon : NSObject

+ (NSString *)getMacAddress;

+ (NSString *)formattedVideoDuration:(NSTimeInterval)duration;

+ (PHAssetCollection *)photoAssetCollection;

+ (NSString *)encodeSpecialString:(NSString *)specialString;

+ (NSString *)decodeSpecialString:(NSString *)specialString;

+ (NSString *)deviceName;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (BOOL)isContainsTwoEmoji:(NSString *)string;

@end
