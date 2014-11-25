//
//  WXYUtil.m
//  微校园
//
//  Created by wuming on 11/15/14.
//  Copyright (c) 2014 wu ming. All rights reserved.
//

#import "WXYUtil.h"

@implementation WXYUtil


+(BOOL)isValidate:(NSString *)object regex:(NSString *)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicte evaluateWithObject:object];
}

+(BOOL)isEmailValidat:(NSString *)string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isEmail =  [emailTest evaluateWithObject:string];
    return isEmail;
    
    
}

+(BOOL)isEmpty:(NSString *)string
{
    
    if ([string length] < 1) {
        return YES;
    }
    else return NO;
}

+(void)alert:(NSString *)title
     message:(NSString *)message
cancelButton:(NSString *)cancelButton{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:nil, nil];
    
    [alertView show];
    
}

@end
