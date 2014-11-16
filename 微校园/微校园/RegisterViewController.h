//
//  RegisterViewController.h
//  微校园
//
//  Created by wuming on 14/11/1.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popUpView.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate,popUpViewDelegate>

@property (nonatomic,strong) NSDictionary *collegesInfo;
@end
