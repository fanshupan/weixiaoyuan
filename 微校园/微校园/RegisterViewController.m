//
//  RegisterViewController.m
//  微校园
//
//  Created by wuming on 14/11/1.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "RegisterViewController.h"

#import "WXYUtil.h"
#import "popUpView.h"
#import "httpClient.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface RegisterViewController ()
@property (nonatomic,strong)    UIScrollView *scrollview;
@property (nonatomic,strong) UITextField *mailField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UIButton *regiestButton;
@property (nonatomic,strong) UISwitch *myswitch;
@property (nonatomic,copy) NSString *single;
@property (nonatomic,strong) UIButton* chooseCollege;
@property (nonatomic,strong) NSString *currentCollegeName;
@property (nonatomic,strong)    popUpView *upView;
@property (nonatomic,strong) UIControl *control;
@end

@implementation RegisterViewController
@synthesize scrollview;
@synthesize upView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerView];
    
    //[self getNSString];
    // Do any additional setup after loading the view.
}

-(void)registerView
{
//    self.single = @"0";
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    //contentSize的意思是：scrollview内容大小
    self.scrollview.contentSize = CGSizeMake(self.scrollview.frame.size.width, self.scrollview.frame.size.height);
    
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
    _nameField.delegate = self;
    
    [self.scrollview addSubview:_nameField];
    
    UILabel *singleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameField.frame),CGRectGetMaxY(_nameField.frame)+10, 200, 30)];
    singleLabel.text = @"显示单身:";
    [self.scrollview addSubview:singleLabel];
    
    [singleLabel sizeToFit];
    
    
    
    self.myswitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(singleLabel.frame)+10, CGRectGetMaxY(_nameField.frame)+10, self.scrollview.frame.size.width-60, 35)];
    

    [self.myswitch addTarget:self action:@selector(changeSwitchValue:) forControlEvents:UIControlEventValueChanged];
    
    self.myswitch.on = YES;
    
    NSLog(@"myswitch %d",self.myswitch.on);
    
    
    self.chooseCollege = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseCollege setTitle:@"选择所在学校" forState:UIControlStateNormal];
    [self.chooseCollege setFrame:CGRectMake(10, CGRectGetMaxY(self.myswitch.frame)+10, self.scrollview.frame.size.width-60, 35)];
    [self.chooseCollege addTarget:self action:@selector(clickCollege) forControlEvents:UIControlEventTouchUpInside];
    
    [self.chooseCollege setBackgroundColor:[UIColor redColor]];
    
    
    [self.scrollview addSubview:self.chooseCollege];
    [self.scrollview addSubview:self.myswitch];
    
    _regiestButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_regiestButton setTitle:@"注册" forState:UIControlStateNormal];
    _regiestButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [_regiestButton setBackgroundColor:[UIColor greenColor]];
    _regiestButton.frame=CGRectMake(30, CGRectGetMaxY(self.chooseCollege.frame)+10, self.scrollview.frame.size.width-60, 35);
    [_regiestButton addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_regiestButton];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard) ];
    [self.scrollview addGestureRecognizer:gesture];
}

-(void)dismissKeyBoard
{
    [_passwordField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_mailField resignFirstResponder];
    [self.scrollview setContentOffset:CGPointMake(0, -44) animated:YES];
    
    self.upView.hidden = YES;

}

-(BOOL)validateDictionary
{
    if (self.single.length < 1) {
        self.single = @"0";
    }
    
    if (![WXYUtil isEmailValidat:_mailField.text]) {
        [WXYUtil alert:@"警告" message:@"邮箱格式不对" cancelButton:@"OK"];
        return NO;
    }
    
    else if ([WXYUtil isEmpty:_nameField.text] || [WXYUtil isEmpty:_passwordField.text]){
        [WXYUtil alert:@"警告" message:@"不能为空" cancelButton:@"OK"];
        return NO;
    }
    
    return YES;

}


-(void)clickRegister
{
    
    
    //第一:检验输入的有效性
    
    //第二:给字典赋值
    
    //第三:传值到服务端
    
    //第四:拿到服务器结果更新UI
    
    
    if (![self validateDictionary])
        return;
    
    NSDictionary *dict2 =@{@"email":_mailField.text,
                           @"password":_passwordField.text,
                           @"nickname":_nameField.text,
                           @"single":self.single,
                           @"school_code":@"szu",
                           @"college_id":@"0",
                           @"source":@"1"};
    
    
    
    [[httpClient sharedClient] POST:@"/api/account/register"
                         parameters:dict2
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                NSDictionary *dict = (NSDictionary *)responseObject;
                                NSLog(@"dict: %@",dict);
                                
                               // validateViewController.validaDict = dict;
                                
                               // [self.navigationController pushViewController:validateViewController animated:YES];
                                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                NSLog(@"test:%@",error);
                            }];
    
    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.scrollview setContentOffset:CGPointMake(0, 50) animated:YES];
    return YES;
}

-(void)changeSwitchValue:(UISwitch *)sender
{
    NSLog(@"switch value:%d",sender.on);
    if (sender.on) {
        self.single = @"1";
    }
    else{
        self.single = @"0";
    }
}

-(void)dismissPopUpView:(UIControl *)sender
{
    if (self.upView.hidden) {
        self.upView.hidden = NO;
        sender.hidden = NO;
    }
    else{
        self.upView.hidden = YES;
        sender.hidden = YES;


    }
    
}

-(void)clickCollege
{
    if (!self.upView) {
        upView=[[popUpView alloc]initWithName:CGRectMake(50, 100, 200, 200) colleges:self.collegesInfo[@"colleges"]];
        upView.delegate = self;
        
        self.control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [self.control addTarget:self action:@selector(dismissPopUpView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.control setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview:self.control];
        
        
        [upView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:upView];
    }
    [self dismissPopUpView:self.control];
   // self.upView.hidden = NO;
    //popUpView *upView = [[popUpView alloc] initWithKey:@"college"];
    
//    self.tabBarController

}

-(void)didSelectIndex:(NSString *)collegeName
{
    self.currentCollegeName = collegeName;
    NSLog(@"collegeName %@",collegeName);
    
    [self.chooseCollege setTitle:self.currentCollegeName forState:UIControlStateNormal];
    [self dismissPopUpView:self.control];
}

@end
