//
//  KSVSVideoModel.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/17.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSVSVideoModel : NSObject
@property (nonatomic, copy) NSString *Id;          // 视频id
@property (nonatomic, copy) NSString *Url;         // 视频播放地址
@property (nonatomic, copy) NSString *Title;       // 视频标题
@property (nonatomic, copy) NSString *UrlExpire;   // 视频地址过期时间戳，当为-1时为永久
@property (nonatomic, copy) NSString *Cover;       // 视频封面地址
@property (nonatomic, copy) NSString *Time;        // 视频创建时间，单位 s
@property (nonatomic, copy) NSString *Width;       // 视频宽度
@property (nonatomic, copy) NSString *Hight;       // 视频高度
@property (nonatomic, copy) NSString *Duration;    // 视频时长，单位 ms
@property (nonatomic, copy) NSString *Author;      // 视频来源/作者
@property (nonatomic, copy) NSString *AuthorCover; // 视频来源/作者的封面/头像
@property (nonatomic, copy) NSString *LikeAmount;  // 视频点赞总数
@property (nonatomic, copy) NSString *Like;        // 当前用户是否点赞：1：已点赞，0：未点赞
@property (nonatomic, copy) NSString *tabId;       // 视频标签
@property (nonatomic, copy) NSString *Ext;         // 额外属性

- (void)configeWithVideoModel:(KSVSVideoModel *)videoModel;

@end
