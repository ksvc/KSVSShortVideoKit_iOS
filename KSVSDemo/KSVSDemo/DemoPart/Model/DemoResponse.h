//
//  DemoResponse.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Signature doesn't match. Please check your request parameters.
 */
static NSInteger const kSignatureNotMatch = -10001;
/**
 * Signature has expired.
 */
static NSInteger const kSignatureExpired = -10002;
/**
 * APIKey (Credential in Authorization header) is invalid. Please check your credential or service status.
 */
static NSInteger const kInvalidToken = -10003;
/**
 * verification code is not match.
 Header %s is required.
 */
static NSInteger const kInvalidParameters = -10004;
/**
 * You're not logged in or it's timeout.
 */
static NSInteger const kNotLoggedIn = -10005;
/**
 * Sms already sent. Please try again later.
 */
static NSInteger const kSmSAlreadySent = -10006;
/**
 * the server encountered an internal error and was unable to complete your request.
 */
static NSInteger const kServerError = -10007;

@interface DemoError : NSObject

@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *Message;

@property (readonly, nonatomic) NSInteger errorCode;

- (void)errorCodeHandler;

@end

@interface DemoResponse : NSObject

@property (nonatomic, copy)   NSString *RequestId;
@property (nonatomic, strong) DemoError *Error;

@property (nonatomic, copy)   NSString *result;
@property (nonatomic, copy)   NSString *message;

@end
