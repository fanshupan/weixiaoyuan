//
//  LoginViewController.h
//  微校园
//
//  Created by wuming on 14/10/18.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^handel)(BOOL finished);

@interface LoginViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITextField *username;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,unsafe_unretained) BOOL         tableviewAnimatFlag;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton     *loginButton;
@property (nonatomic,strong) UIButton     *registerButton;
@property (nonatomic,strong) UIButton    *sinaButton;
@property (nonatomic,strong) UIImageView *logoimgview;
@property (nonatomic,strong) UIImageView *logoimgview2;
@property (nonatomic,unsafe_unretained) BOOL logoFlags;



@end
