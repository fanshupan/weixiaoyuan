//
//  httpClient.h
//  微校园
//
//  Created by shrek on 14/11/2.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"



@interface httpClient : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
