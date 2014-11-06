//
//  httpClient.m
//  微校园
//
//  Created by shrek on 14/11/2.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "httpClient.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"http://vlinju.sinaapp.com";

@implementation httpClient

+(instancetype)sharedClient
{
    static httpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[httpClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        [_sharedClient.requestSerializer setAuthorizationHeaderFieldWithUsername:@"iphone" password:@"a1b2c3d4"];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    
    return _sharedClient;
}

@end
