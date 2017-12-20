//
//  KSVSRespons.h
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/10/26.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

@interface KSVSError : NSObject

@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *Message;

@property (assign, nonatomic) NSInteger errorCode;

- (instancetype)initWithError:(NSError *)error;

- (KSVSError *)errorCodeHandler;

- (void)showErrorInView:(UIView *)showView;

@end

@interface KSVSRespons : NSObject

@property (nonatomic, copy) NSString *RequestId;

@property (nonatomic, strong) KSVSError *Error;

@end
