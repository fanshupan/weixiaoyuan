//
//  LoginViewController.m
//  Weixiaoyuan
//
//  Created by Forrest Wu on 21/3/13.
//  Copyright (c) 2013 Forrest Wu. All rights reserved.
//

#import "LoginViewController.h"
#import "ValidateViewController.h"
#import "StudyTableview.h"
#import "httpClient.h"
#define TABLEWIDTH 310
#define TABLEHEIGHT 130
#define HEIGHT_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5 )



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username,password,tableview;
@synthesize tableviewAnimatFlag;
@synthesize scrollView;
@synthesize loginButton = _loginButton,sinaButton,registerButton = _registerButton;
@synthesize logoimgview;
@synthesize logoimgview2;
@synthesize logoFlags;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)startAnimation
{
    NSArray *array = [NSArray arrayWithObjects:self.logoimgview,self.logoimgview2, nil];
    [self movingAnimatWithcurrentView:nil options:array x:0 y:-150 duration:0.8 handel:^(BOOL finished) {
        if (finished) {
            [self fadeIn:self.tableview withDuration:0.8 andWait:0];
            [self fadeIn:self.registerButton withDuration:0.8 andWait:0];
            [self fadeIn:self.loginButton withDuration:0.8 andWait:0];
            [self fadeIn:self.sinaButton withDuration:0.8 andWait:0];
        }
    }];
}

-(void)initSetupViews
{
    CGFloat extraheight = 0;
    if (IS_IPHONE_5) {
        extraheight = 20;
    }
    
    UIImage *logoimg2 = [UIImage imageNamed:@"logo"];
    logoimgview2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-130, self.view.center.y - 55-extraheight, logoimg2.size.width/2, logoimg2.size.height/2)];
    logoimgview2.image = logoimg2;
    tableviewAnimatFlag = YES;
    logoimgview= [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-55,self.view.center.y - 40-extraheight , 302/2, 92/2)];
    logoimgview.image = [UIImage imageNamed:@"logoword.png"];
    [self.view addSubview:logoimgview2];
    [self.view addSubview:logoimgview];
    UIImageView *defaultpage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    defaultpage.image = [UIImage imageNamed:@"first"];
    [self.view addSubview:defaultpage];
    
//    [UIView animateWithDuration:.5f animations:^{
//        [logoimgview setFrame:CGRectMake(0, 50, logoimgview.frame.size.width-50, logoimgview.frame.size.height-50)];
//    }];
    
//    [UIView animateWithDuration:.5f animations:^{
//        [logoimgview setFrame:CGRectMake(0, 50, logoimgview.frame.size.width-50, logoimgview.frame.size.height-50)];
//
//        
//    } completion:^(BOOL finished) {
//        NSLog(@"ok completed");
//    }];
//
    [UIView animateWithDuration:2.f animations:^{
               defaultpage.alpha = 0;
    } completion:^(BOOL finished) {
        [self initViews:NO];
        [self startAnimation];
    }];
    
//    [UIView animateWithDuration:1 delay:0 options:nil animations:^{
//        defaultpage.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self initViews:NO];
//        [self startAnimation];
//    }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBG-568h@2x"]]];
    
    [self initSetupViews];
    
    
}


#pragma mark - 内存管理

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    // [NSNotificationCenter defaultCenter]
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewWillDisappear:(BOOL)animated{
    // [self viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - 本地方法
- (void) altAnimatePushViewController:(UIViewController *)viewController Animated:(BOOL)animated
{
    [CATransaction begin];
    
    CATransition *transition;
    transition = [CATransition animation];
    transition.type = kCATransitionPush;          // Use any animation type and subtype you like
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1;
    
    CATransition *fadeTrans = [CATransition animation];
    fadeTrans.type = kCATransitionFade;
    fadeTrans.duration = 1;
    
    
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    
    [[[[self.view subviews] objectAtIndex:0] layer] addAnimation:transition forKey:nil];
    [[[[self.view subviews] objectAtIndex:1] layer] addAnimation:fadeTrans forKey:nil];
    
    
    
    [self.navigationController  pushViewController:viewController animated:YES];
    [CATransaction commit];
}


-(void)clickRegister:(id)sender
{
     ValidateViewController *validateViewController= [[ValidateViewController alloc] init];
    [self.navigationController pushViewController:validateViewController animated:YES];
    
    NSDictionary *param = @{@"school_code":@"szu"};
    
    [[httpClient sharedClient] POST:@"/api/school/info"
                         parameters:param
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                NSDictionary *dict = (NSDictionary *)responseObject;
                                NSLog(@"dict: %@",dict);
                               
                                validateViewController.validaDict = dict;   
                                
                                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                NSLog(@"test:%@",error);
                            }];
    
    
    
    
    
    // [self.password resignFirstResponder];
    // [self.username resignFirstResponder];
    //[SVProgressHUD showWithStatus:MyLocal(@"loading")];
    
//    HttpHandle *http = [[HttpHandle alloc]init];
//    [http getCollegeInfoWithBlock:^(BOOL finished, NSArray *collegeList, NSArray *questionList, NSDictionary *collegeInfo) {
//        
//        if (finished) {
//            [SVProgressHUD dismiss];
//            // [self.scrollView setContentOffset:CGPointMake(0, 80) animated:NO];
//            
//            
//            ValidationViewController *validation= [[ValidationViewController alloc]initWithQuestions:questionList colleges:collegeList schoolInfo:collegeInfo];
//            
//            [self.navigationController pushViewController:validation animated:YES];
//            //[self altAnimatePushViewController:validation Animated:YES];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:MyLocal(@"Error")];
//            
//        }
//    }];
}



-(void)clickLogin:(id)sender
{
   // [self checklogin];
    
    
    //"szu"
    NSDictionary *param = @{@"email":@"wxy_3@qq.com",
                            @"password":@"888888"};
    
    [[httpClient sharedClient] POST:@"/api/account/login"
                         parameters:param
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                NSDictionary *dict = (NSDictionary *)responseObject;
                                NSLog(@"dict: %@",dict);

                                if (dict[@"error"]) {
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:dict[@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alertView show];
                                }
                                
                                

                                
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    
    }];
    
    
    //StudyTableview *studyTable = [[StudyTableview alloc] init];
    
   // [self.navigationController pushViewController:studyTable animated:YES];
    
}

-(void)clickSinaLogin:(id)sender
{
//    [SinaSocial shareInstance].delegate= self;
//    [[SinaSocial shareInstance].sinaweibo logIn];
    
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:scrollView];
}
-(void)initViews:(BOOL)hidden
{
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 200, self.view.frame.size.width-10, TABLEHEIGHT) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundView = nil;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.scrollEnabled = NO;
    self.tableview.allowsSelection = YES;
    self.tableview.alpha = 0;
    self.tableview.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    self.tableview.separatorColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    
    //self.tableview.layer.cornerRadius = 8.;
    [self.tableview setHidden:hidden];
    [self.tableview setBackgroundView:nil];
    [self.tableview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableview];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _loginButton.titleLabel.textColor = [UIColor whiteColor];
    _loginButton.frame = CGRectMake(31, self.tableview.frame.origin.y+self.tableview.frame.size.height+10, 113, 41);
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"button_green"]stretchableImageWithLeftCapWidth:8 topCapHeight:0] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setHidden:hidden];
    _loginButton.alpha = 0;
    [self.view addSubview:_loginButton];
    
    _registerButton = [[UIButton alloc]init];
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.textColor = [UIColor whiteColor];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _registerButton.frame = CGRectMake(self.view.frame.size.width - 113 - 31, self.tableview.frame.origin.y+self.tableview.frame.size.height+10, 113, 41);
    [_registerButton setBackgroundImage:[[UIImage imageNamed:@"button_blue"]stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
    [_registerButton setHidden:hidden];
    _registerButton.alpha = 0;
    [_registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
    
    UIImage *sinaButtonImg = [UIImage imageNamed:@"button_sina"];
    sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaButton.titleLabel.textColor = [UIColor colorWithRed:0.196 green:0.310 blue:0.443 alpha:1.000];
    sinaButton.frame = CGRectMake(31, self.tableview.frame.origin.y+self.tableview.frame.size.height+70, sinaButtonImg.size.width, sinaButtonImg.size.height);
    [sinaButton setBackgroundImage:sinaButtonImg forState:UIControlStateNormal];
    [sinaButton setTitle:@"使用新浪微博登陆" forState:UIControlStateNormal];
    [sinaButton setTitleColor:[UIColor colorWithRed:0.196 green:0.310 blue:0.443 alpha:1.000] forState:UIControlStateNormal];
    sinaButton.titleLabel.font= [UIFont boldSystemFontOfSize:15];
    [sinaButton addTarget:self action:@selector(clickSinaLogin:) forControlEvents:UIControlEventTouchUpInside];
    [sinaButton setHidden:hidden];
    sinaButton.alpha = 0;
   // [self.view addSubview:sinaButton];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)onKeyboardHide:(id)sender
{
    
    
}

-(void)fadeIn:(UIView*)viewToFadeIn withDuration:(NSTimeInterval)duration      andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations: @"Fade In" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    viewToFadeIn.alpha = 1;
    [UIView commitAnimations];
}

-(void)fadeOut:(UIView*)viewToDissolve withDuration:(NSTimeInterval)duration   andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations: @"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    viewToDissolve.alpha = 0.0;
    [UIView commitAnimations];
}





-(void)movingAnimatWithcurrentView:(UIView *)pView
                           options:(NSArray *)options
                                 x:(CGFloat)x
                                 y:(CGFloat)y
                          duration:(CGFloat)duration
                            handel:(handel)handel
{
    [UIView animateWithDuration:duration animations:^{
        
        for (UIView *views in options) {
            [views setFrame:CGRectMake(views.frame.origin.x+x,views.frame.origin.y+y ,views.frame.size.width, views.frame.size.height)];
        }
    }
        completion:^(BOOL finished)
     {
         handel(YES);
     }];
    
}


-(void)movingAnimatWithView:(UIView *)pView
                          x:(CGFloat)x
                          y:(CGFloat)y
                   duration:(CGFloat)duration
                     handel:(handel)handel
{
    [UIView animateWithDuration:duration animations:^{
        [pView setFrame:CGRectMake(x,y ,pView.frame.size.width, pView.frame.size.height)];
    }
                     completion:^(BOOL finished)
     {
         handel(YES);
     }];
    
}

-(void)checklogin
{
//    [SVProgressHUD showWithStatus:MyLocal(@"logining")];
//    HttpHandle *http = [[HttpHandle alloc]init];
//    http.delegate =self;
//    __unsafe_unretained HttpHandle *tempHttp = http;
//    [tempHttp cancelAllHttpRequest];
//    
//    [tempHttp loginWithUserName:username.text password:password.text loginblock:^(id returnMSG, BOOL finished) {
//        if (finished) {
//            [SVProgressHUD dismiss];
//            [((AppDelegate *)APPDELEGATE).indexController initData];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//        else
//        {
//            NSDictionary *error = (NSDictionary *)returnMSG;
//            
//            WXYDebug(@"error %@",[error objectForKey:@"error"]);
//            [SVProgressHUD showErrorWithStatus:[error objectForKey:@"error"]];
//            WXYDebug(@"error%@",(NSError *)returnMSG);
//        }
//        
//        
//    }];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cellidentifier1";
    static NSString *CellIdentifier2 = @"Cellidentifier2";
    if (indexPath.row==0)
    {
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell1==nil)
        {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            // [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            // cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            username = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, 270, 30)];
            username.clearButtonMode = UITextFieldViewModeWhileEditing;
            username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            username.autocorrectionType = UITextAutocorrectionTypeNo;
            username.placeholder = @"username";
            username.delegate = self;
            [cell1.contentView addSubview:username];
        }
        
        return cell1;
        
    }else
    {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell2==nil)
        {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            
            password = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, 270, 30)];
            password.clearButtonMode = UITextFieldViewModeWhileEditing;
            password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            password.autocorrectionType = UITextAutocorrectionTypeNo;
            password.placeholder = @"password";
            password.delegate = self;
            password.secureTextEntry = YES;
            
            [password setReturnKeyType:UIReturnKeyGo];
            [cell2 addSubview:password];
        }
        
        return cell2;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.password resignFirstResponder];
    [self.username resignFirstResponder];
    
    if (!tableviewAnimatFlag) {
        
        NSArray *movingArray = [NSArray arrayWithObjects:self.tableview,self.registerButton,self.loginButton,self.sinaButton, nil];
        
        CGFloat movingY =  70;
        if (IS_IPHONE_5) {
            movingY = 50;
        }
        
        [self movingAnimatWithcurrentView:nil options:movingArray x:0 y:movingY duration:0.3f
                                   handel:^(BOOL finished) {
                                       tableviewAnimatFlag = YES;
                                   }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.logoimgview setFrame:CGRectMake(self.logoimgview.frame.origin.x, self.logoimgview.frame.origin.y + 40, self.logoimgview.frame.size.width, self.logoimgview.frame.size.height+10)];
            
            [self.logoimgview2 setFrame:CGRectMake(self.logoimgview2.frame.origin.x, self.logoimgview2.frame.origin.y + 40, self.logoimgview2.frame.size.width, self.logoimgview2.frame.size.height+10)];
        }];
        
    }
    
    
    
    
}
#pragma mark - TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (tableviewAnimatFlag) {
        
        NSArray *movingArray = [NSArray arrayWithObjects:self.tableview,self.registerButton,self.loginButton,self.sinaButton, nil];
        
        CGFloat movingY = - 70;
        if (IS_IPHONE_5) {
            movingY = -50;
        }
        
        [self movingAnimatWithcurrentView:nil options:movingArray x:0 y:movingY duration:0.3f
                                   handel:^(BOOL finished) {
                                       tableviewAnimatFlag = NO;
                                   }];
        [UIView animateWithDuration:0.3 animations:^{
            [self.logoimgview setFrame:CGRectMake(self.logoimgview.frame.origin.x, self.logoimgview.frame.origin.y - 40, self.logoimgview.frame.size.width, self.logoimgview.frame.size.height-10)];
            
            [self.logoimgview2 setFrame:CGRectMake(self.logoimgview2.frame.origin.x, self.logoimgview2.frame.origin.y - 40, self.logoimgview2.frame.size.width, self.logoimgview2.frame.size.height-10)];
        }];
        
    }
    
    
    
    
    
    return YES;
    
}

-(void)overviewTarget:(id)sender
{
    UIControl *touchControl = (UIControl *)sender;
    
    [touchControl removeFromSuperview];
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == username) {
        [password becomeFirstResponder];
    }
    
    if (textField == password) {
        
        [self checklogin];
    }
    return YES;
}

#pragma mark - 新浪微博的回调
-(void)sinaGetbackWithName:(NSString *)returnTypes;
{
    if ([returnTypes isEqualToString:@"sinaweiboLogInDidCancel"]) {
        
    }
    else if([returnTypes isEqualToString:@"sinaweiboDidLogIn"])
    {
        
    }
    else if([returnTypes isEqualToString:@"sinaweiboAccessTokenInvalidOrExpired"])
    {
        //[[SinaSocial shareInstance].sinaweibo logIn];
    }
}
//
//-(void)sinaGetbackWithSina:(SinaWeibo *)sinaObj
//{
//    [SVProgressHUD showWithStatus:MyLocal(@"loading")];
//    HttpHandle *http = [[HttpHandle alloc]init];
//    __unsafe_unretained HttpHandle *temp = http;
//    
//    [temp loginWithSinaWithoauthToken:sinaObj.accessToken token_expires:[NSString stringWithFormat:@"%@",sinaObj.expirationDate] sinaweiboBlock:^(BOOL finished, NSDictionary *returnMsg) {
//        if (finished) {
//            [SVProgressHUD dismiss];
//            if ([[returnMsg objectForKey:@"id"] length] < 1) {
//                [self clickRegister:nil];
//            }
//            else
//            {
//                [((AppDelegate *)APPDELEGATE).indexController initData];
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:MyLocal(@"Error")];
//        }
//    }];
//    /*
//     [temp sinaBindWithUid:sinaObj.userID  oauth_token:sinaObj.accessToken oauthtokenExpire:sinaObj.expirationDate accountbindBlock:^(BOOL finished, NSDictionary *returnMsg) {
//     [SVProgressHUD dismiss];
//     NSString *error = [returnMsg objectForKey:@"Error"];
//     //NSString *nickname = [returnMsg objectForKey:@"nickname"];
//     if ([error length] > 0 || !finished)
//     {
//     UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:MyLocal(@"notification") message:error delegate:self cancelButtonTitle:MyLocal(@"OK") otherButtonTitles:nil, nil];
//     [alertview show];
//     }
//     else
//     {
//     
//     WXYDebug(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaObj.userID, sinaObj.accessToken, sinaObj.expirationDate,sinaObj.refreshToken);
//     NSDictionary *sinaDic = DICT(sinaObj.userID,@"userID",
//     sinaObj.accessToken,@"accessToken",
//     sinaObj.expirationDate,@"expirationDate"
//     );
//     [Utility setUserDefaultsWithObjectKey:DEFAULT_SINA objectType:sinaDic];
//     
//     }
//     
//     }];
//     */
//}



#pragma mark - http Delegate

- (void)httpRequestFinish
{
    NSLog(@"http Request finished111");
}

-(void)httpRequestFail
{
    NSLog(@"http request fail");
}

@end
