//
//  DemoNetworkService.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/25.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoNetworkService.h"
#import "DemoServerConfige.h"
#import "AFNetworking.h"
#import "NSObject+YYModel.h"
#import "NSString+YYAdd.h"
#import "DemoUser.h"
#import "DemoCommon.h"

@implementation DemoNetworkService

+ (void)demo_get:(NSString*) url
         queries:(NSDictionary*)queries
           token:(NSString *)token
    concactedKey:(NSString *)concactedKey
      responseClass:(Class)responseClass
         complete:(void(^)(id response, DemoError *demoError))complete
{
    UInt64 timeStamp = (UInt64)[[NSDate date] timeIntervalSince1970];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"X-KMS-OS"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"X-KMS-OSVersion"];
    [manager.requestSerializer setValue:[[NSUUID UUID] UUIDString]  forHTTPHeaderField:@"X-KMS-DeviceId"];
    [manager.requestSerializer setValue:[@(timeStamp) stringValue] forHTTPHeaderField:@"X-KMS-Timestamp"];
    [manager.requestSerializer setValue:DEMO_BUNDLEID forHTTPHeaderField:@"X-KMS-PackageName"];
    [manager.requestSerializer setValue:[self get_AuthWithQueries:queries timeStamp:[@(timeStamp) stringValue] path:url token:token concactedKey:concactedKey] forHTTPHeaderField:@"Authorization"];
    
    NSString *aurl = [DEMO_SERVER_HOST stringByAppendingString:url];
    
    [manager GET:aurl parameters:queries progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseClass) {
            id responseModel = nil;
            DemoError *demoErr = nil;
            responseModel = [responseClass modelWithJSON:responseObject];
            if ([responseModel isKindOfClass:[DemoResponse class]]) {
                demoErr = [responseModel Error];
            }
            if (demoErr.errorCode == kNotLoggedIn) {
                // 再另一台手机上登录之后，返回未登录状态
                [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
            } else {
                complete(responseModel, demoErr);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *oneKey = @"com.alamofire.serialization.response.error.data";
        NSArray *keys = error.userInfo.allKeys;
        for (NSString *key in keys) {
            if ([key isEqualToString:oneKey]) {
                id data = error.userInfo[oneKey];
                if ([data isKindOfClass:[NSData class]]) {
                    if (responseClass) {
                        id responseModel = nil;
                        DemoError *demoErr = nil;
                        responseModel = [responseClass modelWithJSON:data];
                        if ([responseModel isKindOfClass:[DemoResponse class]]) {
                            demoErr = [responseModel Error];
                            [demoErr errorCodeHandler];
                        }
                        if (demoErr.errorCode == kNotLoggedIn) {
                            // 在另一台手机上登录之后，返回未登录状态
                            [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
                        } else {
                            complete(nil, demoErr);
                        }
                    }
                }
                break;
            }
        }
    }];
}

+ (void)demo_post:(NSString*) url
         queries:(NSDictionary*)queries
           token:(NSString *)token
    concactedKey:(NSString *)concactedKey
   responseClass:(Class)responseClass
        complete:(void(^)(id response, DemoError *demoError))complete
{
    UInt64 timeStamp = (UInt64)[[NSDate date] timeIntervalSince1970];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"X-KMS-OS"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"X-KMS-OSVersion"];
    [manager.requestSerializer setValue:[[NSUUID UUID] UUIDString]  forHTTPHeaderField:@"X-KMS-DeviceId"];
    [manager.requestSerializer setValue:[@(timeStamp) stringValue] forHTTPHeaderField:@"X-KMS-Timestamp"];
    [manager.requestSerializer setValue:DEMO_BUNDLEID forHTTPHeaderField:@"X-KMS-PackageName"];
    [manager.requestSerializer setValue:[self post_AuthWithQueries:queries timeStamp:[@(timeStamp) stringValue] path:url token:token concactedKey:concactedKey] forHTTPHeaderField:@"Authorization"];

    NSString *aurl = [DEMO_SERVER_HOST stringByAppendingString:url];
    
    [manager POST:aurl parameters:queries progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseClass) {
            id responseModel = nil;
            DemoError *demoErr = nil;
            responseModel = [responseClass modelWithJSON:responseObject];
            if ([responseModel isKindOfClass:[DemoResponse class]]) {
                demoErr = [responseModel Error];
            }
            
            if (demoErr.errorCode == kNotLoggedIn) {
                // 在另一台手机上登录之后，返回未登录状态
                [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
            } else {
                complete(responseModel, demoErr);
            }
            
//            complete(responseModel, demoErr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *oneKey = @"com.alamofire.serialization.response.error.data";
        NSArray *keys = error.userInfo.allKeys;
        for (NSString *key in keys) {
            if ([key isEqualToString:oneKey]) {
                id data = error.userInfo[oneKey];
                if ([data isKindOfClass:[NSData class]]) {
                    NSLog(@"");
                    if (responseClass) {
                        id responseModel = nil;
                        DemoError *demoErr = nil;
                        responseModel = [responseClass modelWithJSON:data];
                        if ([responseModel isKindOfClass:[DemoResponse class]]) {
                            demoErr = [responseModel Error];
                            [demoErr errorCodeHandler];
                        }
                        if (demoErr.errorCode == kNotLoggedIn) {
                            // 在另一台手机上登录之后，返回未登录状态
                            [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
                        } else {
                            complete(nil, demoErr);
                        }
                    }
                }
            }
        }
    }];
}

#pragma mark ----------- Auth

+ (NSString *)get_AuthWithQueries:(NSDictionary *)queries
                    timeStamp:(NSString *)timeStamp
                         path:(NSString *)path
                        token:(NSString *)token
                 concactedKey:(NSString *)concactedKey {
    NSString *credential = token;
    NSString *signature = [self signatureWithTimeStamp:timeStamp queries:queries path:path concactedKey:concactedKey method:@"GET"];
    return [NSString stringWithFormat:@"Credential=%@,Signature=%@", credential, signature];
}

+ (NSString *)post_AuthWithQueries:(NSDictionary *)queries
                        timeStamp:(NSString *)timeStamp
                             path:(NSString *)path
                            token:(NSString *)token
                     concactedKey:(NSString *)concactedKey {
    NSString *credential = token;
    NSString *signature = [self signatureWithTimeStamp:timeStamp queries:queries path:path concactedKey:concactedKey method:@"POST"];
    return [NSString stringWithFormat:@"Credential=%@,Signature=%@", credential, signature];
}

+ (NSString *)signatureWithTimeStamp:(NSString *)timeStamp
                             queries:(NSDictionary*)queries
                                path:(NSString *)path
                        concactedKey:(NSString *)concactedKey method:(NSString *)method{
    NSString *outLineString = nil;
    if ([method isEqualToString:@"POST"]) {
        outLineString = [self post_ParamOutLineStringWithPath:path];
    } else if ([method isEqualToString:@"GET"]) {
        outLineString = [self get_ParamOutLineStringWithPath:path];
    }
    NSString *keyvalueConcactedString = [self paramKeyvalueConcactedStringWithqueries:queries];
    NSString *timeStampConcatedWithKey = [self timeStamp:timeStamp concatedWithKey:concactedKey];

    NSString *md5Source = outLineString;
    if ([method isEqualToString:@"GET"]) {  // POST请求的body部分不加入签名计算
        if (keyvalueConcactedString && md5Source) {
            md5Source = [md5Source stringByAppendingString:keyvalueConcactedString];
        } else if (!md5Source) {
            md5Source = keyvalueConcactedString;
        }
    }
    if (timeStampConcatedWithKey && md5Source) {
        md5Source = [md5Source stringByAppendingString:timeStampConcatedWithKey];
    }else if (!md5Source) {
        md5Source = timeStampConcatedWithKey;
    }
    NSString *md5Rst = [md5Source md5String];
    
    NSLog( @"md5Source = %@", md5Source);
    NSLog( @"md5Rst = %@", md5Rst);
    return md5Rst;
}

+ (NSString *)get_ParamOutLineStringWithPath:(NSString *)path {
    return [NSString stringWithFormat:@"GET\n%@\n%@\n", DEMO_DOMAIN, path];
}

+ (NSString *)post_ParamOutLineStringWithPath:(NSString *)path {
    return [NSString stringWithFormat:@"POST\n%@\n%@\n", DEMO_DOMAIN, path];
}

/** 参数正序拼接成 key1=value1&key2=value2...
 * 如果参数为空，则只拼接key，形如key1&key2
 */
+ (NSString *)paramKeyvalueConcactedStringWithqueries:(NSDictionary*)queries {
    
    NSDictionary *params = queries;
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *concactedString = nil;
    for (NSInteger i = 0; i < sortedKeys.count; ++i) {
        
        if ([params[sortedKeys[i]] isEqual:[NSNull null]]) {
            if (!concactedString) {
                concactedString = sortedKeys[i];
            } else {
                concactedString = [concactedString stringByAppendingString:sortedKeys[i]];
            }
            if (i < sortedKeys.count - 1) {
                concactedString = [concactedString stringByAppendingString:@"&"];
            }
            if (i == sortedKeys.count - 1) {
                concactedString = [concactedString stringByAppendingString:@"\n"];
            }
            continue;
        }
        if (!concactedString) {
            concactedString = sortedKeys[i];
        } else {
            concactedString = [concactedString stringByAppendingString:sortedKeys[i]];
        }
        concactedString = [concactedString stringByAppendingString:@"="];
        
        NSString *appendString = params[sortedKeys[i]];
        if ([params[sortedKeys[i]] isKindOfClass:[NSNumber class]]) {
            appendString = [params[sortedKeys[i]] stringValue];
        }
        concactedString = [concactedString stringByAppendingString:appendString];
        
        if (i < sortedKeys.count - 1) {
            concactedString = [concactedString stringByAppendingString:@"&"];
        }
        if (i == sortedKeys.count - 1) {
            concactedString = [concactedString stringByAppendingString:@"\n"];
        }
    }
    return concactedString;
}

+ (NSString *)timeStamp:(NSString *)timeStamp concatedWithKey:(NSString *)concatedKey {
    return [timeStamp stringByAppendingString:(concatedKey ?: @"")];
}

#pragma mark --
#pragma mark --  Public Network API

+ (void)fetchProfileWithComplete:(void(^)(DemoProfileResponse *response, DemoError *demoError))complete {
    NSString *urlString = kFetchProfiletPath;
    NSString *token = kCurrUser.token;
    NSString * concactedKey = kCurrUser.token;
    [self demo_get:urlString queries:nil token:token concactedKey:concactedKey responseClass:[DemoProfileResponse class] complete:complete];
}

+ (void)fetchVerificationCodeWithMobile:(NSString *)mobile
                               complete:(void(^)(DemoVerificationCodeResponse *response, DemoError *demoError))complete
{
    NSString *urlString = kFetchMobileVerCodePath;
    NSString *token = kDemoAuthToken;
    NSString * concactedKey = kDemoAuthKey;
    NSDictionary *queries = @{@"deviceId" : [DemoCommon getMacAddress],
                              @"mobile" : mobile
                              };
    [self demo_get:urlString queries:queries token:token concactedKey:concactedKey responseClass:[DemoVerificationCodeResponse class] complete:complete];
}

+ (void)loginWithMobile:(NSString *)mobile
                verCode:(NSString *)verCode
               complete:(void(^)(DemoVerificationCodeLoginResponse *response, DemoError *demoError))complete {
    NSString *urlString = kMobileVerCodeLoginPath;
    NSString *token = kDemoAuthToken;
    NSString * concactedKey = kDemoAuthKey;
    NSDictionary *queries = @{@"deviceId" : [DemoCommon getMacAddress],
                              @"mobile" : mobile,
                              @"code" : verCode
                              };
    [self demo_post:urlString queries:queries token:token concactedKey:concactedKey responseClass:[DemoVerificationCodeLoginResponse class] complete:complete];
}

+ (void)loginOutComplete:(void(^)(DemoLoginOutResponse *response, DemoError *demoError))complete {
    NSString *urlString = kLoginOutPath;
    NSString *token = kCurrUser.token;
    NSString * concactedKey = kCurrUser.token;
    [self demo_get:urlString queries:nil token:token concactedKey:concactedKey responseClass:[DemoLoginOutResponse class] complete:complete];
}

+ (void)updateProfileWithHeadUrlPath:(NSString *)headUrlPath
                            nickname:(NSString *)nickname
                              gender:(BOOL)gender
                            complete:(void(^)(DemoUpdateProfileResponse *response, DemoError *demoError))complete {
    NSString *urlString = kUpdateProfiletPath;
    NSString *token = kCurrUser.token;
    NSString * concactedKey = kCurrUser.token;
    NSDictionary *queries = @{@"nickname" : nickname ?: @"",
                              @"gender" : [NSNumber numberWithBool:gender],
                              @"headUrlPath" : headUrlPath ?: @""
                              };
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:queries];
    if (headUrlPath) {
        [params setValue:headUrlPath forKey:headUrlPath];
    }
    [self demo_post:urlString queries:params token:token concactedKey:concactedKey responseClass:[DemoUpdateProfileResponse class] complete:complete];
}

@end
