//
//  KSVSVideoModel.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/17.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSVSVideoModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Url;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *UrlExpire;
@property (nonatomic, copy) NSString *Cover;
@property (nonatomic, copy) NSString *Time;
@property (nonatomic, copy) NSString *Width;
@property (nonatomic, copy) NSString *Hight;
@property (nonatomic, copy) NSString *Duration;
@property (nonatomic, copy) NSString *Author;
@property (nonatomic, copy) NSString *AuthorCover;
@property (nonatomic, copy) NSString *LikeAmount;
@property (nonatomic, copy) NSString *Like;
@property (nonatomic, copy) NSString *tabId;
@property (nonatomic, copy) NSString *Ext;

- (void)configeWithVideoModel:(KSVSVideoModel *)videoModel;

@end
