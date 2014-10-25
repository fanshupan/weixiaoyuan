//
//  LoginViewController.m
//  微校园
//
//  Created by wuming on 14/10/18.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "LoginViewController.h"
#import "ValidateViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong)UITextField *emailField;
@property (nonatomic,strong)UITextField *passwordField;
@property (nonatomic,strong) ValidateViewController *validateViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBG-568h@2x"]]];
    
    
    self.emailField=[[UITextField alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 30)];
    self.emailField.placeholder=@"Email";
    self.emailField.backgroundColor=[UIColor whiteColor];
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.emailField];
    
    self.emailField.delegate = self;
    
    
    self.passwordField=[[UITextField alloc]initWithFrame:CGRectMake(10, 135, self.view.frame.size.width-20, 30)];
    self.passwordField.placeholder=@"Password";
    self.passwordField.backgroundColor=[UIColor whiteColor];
    self.passwordField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.passwordField.secureTextEntry = YES;
   // passwordField.delegate= self;
    [self.view addSubview:self.passwordField];
    
    
    UITextField *testField=[[UITextField alloc]initWithFrame:CGRectMake(10, 170, 100, 25)];
    testField.backgroundColor=[UIColor redColor];
    [self.view addSubview:testField];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor=[UIColor colorWithRed:141/255.0f green:203/255.0f blue:31/255.0f alpha:1.0];
    [loginButton setFrame:CGRectMake(10, CGRectGetMaxY( self.passwordField.frame) + 20, 113, 41)];
    [self.view addSubview:loginButton];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
   
    UIButton *registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:156/255.0f blue:225/255.0f alpha:1.0]];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateHighlighted];
    [registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [registerButton setFrame:CGRectMake(self.view.frame.size.width - 113 - 10,CGRectGetMinY(loginButton.frame), 113, 41)];
    [self.view addSubview:registerButton];
    
    [registerButton addTarget:self action:@selector(doRegister:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard) ];
    [self.view addGestureRecognizer:gesture];
    
    
    
    
    
    
   // CGRectGetMinY == registerButton.frame.origin.y
    // Do any additional setup after loading the view.
}

-(void)doRegister:(id)sender
{
    //[self.emailField becomeFirstResponder];
   // self.passwordField.secureTextEntry =NO;
    
    self.validateViewController = [[ValidateViewController alloc] init];
    
    [self.navigationController pushViewController:self.validateViewController animated:YES];
    
}

-(void)dismissKeyBoard
{
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

-(void)doLogin:(id)sender
{
  //  UIButton *tempBtn = (UIButton *)sender;
    
    //[tempBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"消息" message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再试一遍", nil];
    
    [alertView show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"click cancel");
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"try again");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
        return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.layer.borderColor = [UIColor redColor].CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.layer.masksToBounds=YES;

    
    NSLog(@"text field %@",textField.text);
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
