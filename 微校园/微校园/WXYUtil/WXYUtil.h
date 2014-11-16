//
//  WXYUtil.h
//  微校园
//
//  Created by wuming on 11/15/14.
//  Copyright (c) 2014 wu ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WXYUtil : NSObject

+(BOOL)isEmailValidat:(NSString *)string;
+(BOOL)isEmpty:(NSString *)string;

+(void)alert:(NSString *)title
     message:(NSString *)message
cancelButton:(NSString *)cancelButton;

+(BOOL)isValidate:(NSString *)object regex:(NSString *)regex;

@end
