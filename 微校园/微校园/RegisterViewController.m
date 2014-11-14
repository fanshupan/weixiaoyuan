//
//  RegisterViewController.m
//  微校园
//
//  Created by wuming on 14/11/1.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "RegisterViewController.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface RegisterViewController ()
@property (nonatomic,strong)    UIScrollView *scrollview;
@property (nonatomic,strong) UITextField *mailField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UIButton *regiestButton;
@end

@implementation RegisterViewController
@synthesize scrollview;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerView];
    // Do any additional setup after loading the view.
}

-(void)registerView
{
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.scrollview setBackgroundColor:RGBACOLOR(240, 240, 240, 1.0f)];
    [self.view addSubview:scrollview];
    self.navigationItem.title = @"注册";
    
    _mailField=[[UITextField alloc]initWithFrame:CGRectMake(30, 35, self.scrollview.frame.size.width-60, 35)];
    _mailField.background=[UIImage imageNamed:@"input_sumbit"];
    _mailField.placeholder=@"     请输入你的邮箱地址";
    _mailField.clearButtonMode=UITextFieldViewModeWhileEditing;
    UIImageView *mailImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"018"]];
    _mailField.leftView=mailImage;
    _mailField.leftViewMode=UITextFieldViewModeAlways;
    [self.scrollview addSubview:_mailField];
    
    _passwordField=[[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_mailField.frame)+10, self.scrollview.frame.size.width-60, 35)];
    _passwordField.background=[UIImage imageNamed:@"input_sumbit"];
    _passwordField.placeholder=@"     请输入你的密码";
    _passwordField.clearButtonMode=UITextFieldViewModeWhileEditing;
    UIImageView *passwordImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"018"]];
    _passwordField.leftView=passwordImage;
    _passwordField.leftViewMode=UITextFieldViewModeAlways;
    _passwordField.secureTextEntry=YES;
    [self.scrollview addSubview:_passwordField];
    
    _nameField=[[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_passwordField.frame)+10, self.scrollview.frame.size.width-60, 35)];
    _nameField.background=[UIImage imageNamed:@"input_sumbit"];
    _nameField.placeholder=@"     请输入你的昵称";
    _nameField.clearButtonMode=UITextFieldViewModeAlways;
    UIImageView *nameImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"018"]];
    _nameField.leftView=nameImage;
    _nameField.leftViewMode=UITextFieldViewModeAlways;
    [self.scrollview addSubview:_nameField];
    
    _regiestButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_regiestButton setTitle:@"注册" forState:UIControlStateNormal];
    _regiestButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [_regiestButton setBackgroundColor:[UIColor greenColor]];
    _regiestButton.frame=CGRectMake(30, CGRectGetMaxY(_nameField.frame)+10, self.scrollview.frame.size.width-60, 35);
    [_regiestButton addTarget:self action:@selector(getNSString) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_regiestButton];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard) ];
    [self.scrollview addGestureRecognizer:gesture];
}

-(void)dismissKeyBoard
{
    [_passwordField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_mailField resignFirstResponder];
}


-(void)getNSString
{
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:_mailField.text,@"mail",_passwordField.text,@"password",_nameField,@"name", nil];
    NSLog(@"dict %@",dict);
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
