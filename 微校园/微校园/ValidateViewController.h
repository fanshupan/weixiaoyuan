//
//  ValidateViewController.h
//  微校园
//
//  Created by wuming on 14/10/25.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol validateViewControllerDelegate <NSObject>

@optional
-(void)changeUserName;

@end

@interface ValidateViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic,strong) NSDictionary *validaDict;
@property (nonatomic,assign) id delegate;

@end
