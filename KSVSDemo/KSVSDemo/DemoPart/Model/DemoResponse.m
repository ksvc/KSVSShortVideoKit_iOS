//
//  DemoResponse.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoResponse.h"

@interface DemoError ()

@end

@implementation DemoError

+ (NSArray *)modelPropertyBlacklist {
    return @[@"errorCode"];
}

- (void)errorCodeHandler {
    if ([_Code isEqualToString:@"SignatureNotMatch"]) {
        _errorCode = kSignatureNotMatch;
    } else if ([_Code isEqualToString:@"SignatureExpired"]) {
        _errorCode = kSignatureExpired;
    } else if ([_Code isEqualToString:@"InvalidToken"]) {
        _errorCode = kInvalidToken;
    } else if ([_Code isEqualToString:@"InvalidParameters"]) {
        _errorCode = kInvalidParameters;
    } else if ([_Code isEqualToString:@"NotLoggedIn"]) {
        _errorCode = kNotLoggedIn;
    } else if ([_Code isEqualToString:@"SmSAlreadySent"]) {
        _errorCode = kSmSAlreadySent;
    } else if ([_Code isEqualToString:@"ServerError"]) {
        _errorCode = kServerError;
    }
}

@end

@implementation DemoResponse

@end
