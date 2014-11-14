//
//  ValidateViewController.m
//  微校园
//
//  Created by wuming on 14/10/25.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "ValidateViewController.h"
#import "RegisterViewController.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


@interface ValidateViewController ()

@property (nonatomic,strong)    NSMutableArray *questions;
@property (nonatomic,strong)    NSMutableArray *hints;
@property (nonatomic,strong)    NSMutableArray *answer;
@property (nonatomic,strong)    UITextField *textField;
@property (nonatomic,assign)    int currentIndex;
@property (nonatomic,strong)    UILabel *questionLabel;
@property (nonatomic,strong)    UIScrollView *scrollview;
@property (nonatomic,strong)    UILabel * hintLabel;
@property (nonatomic,strong)    UIButton *answerButton;
@property (nonatomic,strong)    UIButton *changeButton;
@property (nonatomic,strong)    UITextField *answerField;
@property (nonatomic,assign)    int countAnswer;
@end

@implementation ValidateViewController
@synthesize textField;
@synthesize questionLabel = _questionLabel;
@synthesize hintLabel = _hintLabel;
@synthesize scrollview;
@synthesize hints;
@synthesize answerButton = _answerButton;
@synthesize changeButton = _changeButton;
@synthesize answerField = _answerField;
@synthesize countAnswer = _countAnswer;

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initViews
{
    self.questions = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.hints = [[NSMutableArray alloc] initWithCapacity:0];
    self.answer = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.scrollview setBackgroundColor:RGBACOLOR(240, 240, 240, 1.0f)];
    [self.view addSubview:scrollview];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"navigationbar_left_picture_back_icon"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIImage *logobgimg = [UIImage imageNamed:@"szu_bg.jpeg"];
    
    UIImageView * logoBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 115)];
    logoBg.image = logobgimg;
    [self.scrollview addSubview:logoBg];
    
    UILabel *schoolName = [[UILabel alloc] initWithFrame:CGRectMake(90, 27, 200, 30)];
    [schoolName setBackgroundColor:[UIColor clearColor]];
    
    schoolName.text=[_validaDict objectForKey:@"name"];

    schoolName.textColor = [UIColor whiteColor];
    schoolName.font = [UIFont boldSystemFontOfSize:17];
    
    //schoolName.text = @"深圳大学";
    [self.scrollview addSubview:schoolName];
    
    UIImage *logoImg = [UIImage imageNamed:@"szu_logo.jpeg"];
    
    UIImageView *schoolLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 28.5, logoImg.size.width/2, logoImg.size.height/2)];
    schoolLogo.image = logoImg;
    
    [self.scrollview addSubview:schoolLogo];
    
    UIImageView *iconhead = [[UIImageView alloc]init];
//[iconhead setImageNameAndFrame:@"icon_head" x:90 y:70];
    [self.scrollview addSubview:iconhead];
    
    UILabel *numberOfStudent = [[UILabel alloc]initWithFrame:CGRectMake(110,62,250,30)];
    [numberOfStudent setBackgroundColor:[UIColor clearColor]];
    [numberOfStudent setTextColor:[UIColor whiteColor]];
    [numberOfStudent setFont:[UIFont boldSystemFontOfSize:15]];
    numberOfStudent.text = [NSString stringWithFormat:@"%@名学生已经加入",@"1000"];
    [self.scrollview addSubview:numberOfStudent];
    CGFloat extraHeight = 0;
    
//    if (IS_IPHONE_5 ) {
//        extraHeight = 90;
//    }
    UIImageView *loginbg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 120, self.view.frame.size.width-10, 290+extraHeight)];
    UIImage *loginimage = [UIImage imageNamed:@"login_bg"];
    loginbg.image = loginimage;
    [self.scrollview addSubview:loginbg];
    
    UILabel *firstLine = [[UILabel alloc]initWithFrame:CGRectMake(31, 160, 300, 30)];
    
    firstLine.text = [NSString stringWithFormat:@"为了确认您是%@的学生,请回答:",schoolName.text];
    firstLine.backgroundColor = [UIColor clearColor];
    firstLine.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
    firstLine.font = [UIFont systemFontOfSize:15];
    [self.scrollview addSubview:firstLine];
    
    
    _currentIndex=0;
    

    NSArray *questionsArray = _validaDict[@"questions"];
    
    for (int i = 0; i < [questionsArray count]; i++) {
        NSDictionary *tempQuestions = [questionsArray objectAtIndex:i];
        [_questions addObject:tempQuestions[@"question"]];
        [hints addObject:tempQuestions[@"hint"]];
        [self.answer addObject:tempQuestions[@"answer"]];

    }
    
    
    
    
    
//    for (_currentIndex=0; _currentIndex<=2; _currentIndex++) {
//        NSMutableArray *questionMutableArray=(NSMutableArray *)_validaDict[@"questions"];
//        NSDictionary *questionDictionary=[questionMutableArray objectAtIndex:_currentIndex];
//        NSString *qusetionString=[questionDictionary objectForKey:@"question"];
//        [_questions insertObject:qusetionString atIndex:_currentIndex];
//    }
//    //_questions=(NSMutableArray *)_validaDict[@"questions"];
//    for (_currentIndex=0; _currentIndex<=2; _currentIndex++) {
//        NSMutableArray *hintMutableArray=(NSMutableArray *)_validaDict[@"questinos"];
//        NSDictionary *hintDictionary=[hintMutableArray objectAtIndex:_currentIndex];
//        NSString *hintString=[hintDictionary objectForKey:@"hint"];
//        [self.hints insertObject:hintString atIndex:_currentIndex];
//    }
//    
//    for (_currentIndex=0; _currentIndex<=2; _currentIndex++) {
//        NSMutableArray *answerMutableArray=(NSMutableArray *)_validaDict[@"questinos"];
//        NSDictionary *answerDictionary=[answerMutableArray objectAtIndex:_currentIndex];
//        NSString *answerString=[answerDictionary objectForKey:@"answer"];
//        [self.answer insertObject:answerString atIndex:_currentIndex];
//    }
    
    
    
    
    _questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 190, 250, 50)];
    _questionLabel.text = [self.questions objectAtIndex:_currentIndex];
    _questionLabel.font = [UIFont systemFontOfSize:15];
    _questionLabel.backgroundColor = [UIColor clearColor];
    _questionLabel.numberOfLines = 0;
    [self.scrollview addSubview:_questionLabel];
    
    
    
    
    _hintLabel  = [[UILabel alloc]initWithFrame:CGRectMake(31, 280, 300, 30)];
        _hintLabel.backgroundColor = [UIColor clearColor];
    _hintLabel.text = [self.hints objectAtIndex:_currentIndex];
    _hintLabel.font = [UIFont systemFontOfSize:12];
    _hintLabel.backgroundColor = [UIColor clearColor];
    _hintLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
    [self.scrollview addSubview:_hintLabel];
    
    
    _answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_answerButton setTitle:@"回答问题" forState:UIControlStateNormal];
    _answerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _answerButton.frame = CGRectMake(31, _hintLabel.frame.origin.y + 30, 113, 41);
    [_answerButton setBackgroundImage:[[UIImage imageNamed:@"button_green"]stretchableImageWithLeftCapWidth:8 topCapHeight:0] forState:UIControlStateNormal];
    [_answerButton addTarget:self action:@selector(pushSchoollist:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.scrollview addSubview:_answerButton];
    
    _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_changeButton setTitle:@"更换答案" forState:UIControlStateNormal];
    _changeButton.frame = CGRectMake(178,  _hintLabel.frame.origin.y + 30, 113, 41);
    _changeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_changeButton setBackgroundImage:[[UIImage imageNamed:@"button_blue"]stretchableImageWithLeftCapWidth:8 topCapHeight:0] forState:UIControlStateNormal];
    
    [_changeButton addTarget:self action:@selector(refreshQuestion:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollview addSubview:_changeButton];
    
    
    UIView *lbl_pass = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 21)];
    lbl_pass.backgroundColor = [UIColor clearColor];
    
    // lbl.textColor = [UIColor lightGrayColor];
    
    _answerField = [[UITextField alloc]initWithFrame:CGRectMake(30,241 ,261 ,40)];
    [_answerField setBackground:[UIImage imageNamed:@"input_sumbit"]];
    _answerField.leftViewMode = UITextFieldViewModeAlways;
    _answerField.leftView = lbl_pass;
    _answerField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _answerField.placeholder = @"请输入您的答案...";
    _answerField.delegate = self;
    _answerField.returnKeyType = UIReturnKeyDone;
    [self.scrollview addSubview:_answerField];
    _countAnswer = 0;
      
    
    //self.navigationController.navigationBar.barTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar-bg-blue-cornered"]];
    //self.navigationItem.title = @"验明正身";
    

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self initViews];
    

    // Do any additional setup after loading the view.
   // [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    
    //[self.navigationController.navigationBar setTintColor:[UIColor redColor]];
  //  [self.navigationController.navigationBar setTranslucent:NO];

    
    //改变bar的颜色
  //  [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //改变成图片
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"szu_bg.jpeg"] forBarMetrics:UIBarMetricsDefault];
    //改变返回按钮的颜色
    //[self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
    
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"arrow_left"]];
//
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"arrow_left"]];
//    
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
//    [backBtn setFrame:CGRectMake(0, 0, 50, 50)];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    
//    self.navigationItem.leftBarButtonItem = item;
//    
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [rightBtn setTitle:@"右边" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [rightBtn setFrame:CGRectMake(10000, 1000, 50, 50)];
//    
//    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//
//    self.navigationItem.rightBarButtonItem = rightitem;
//
//    [self.view setBackgroundColor:[UIColor whiteColor]];
//    
//    self.navigationItem.title = @"注册";
//    self.currentIndex = 0;
//    
//    
//    self.questions = [[NSMutableArray alloc] initWithObjects:@"1+1=",@"2+2=",@"3+3=", nil];
//    self.answer = [[NSMutableArray alloc] initWithObjects:@"2",@"4",@"6", nil];
//    
//    
//    _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 250, 20)];
//    
//    _questionLabel.text = [self.questions objectAtIndex:self.currentIndex];
//    
//    [self.view addSubview:_questionLabel];
//    
//    
//    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
//   // textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.placeholder = @"Please Enter:";
//    
//    textField.layer.borderWidth = 1.0f;
//    textField.layer.borderColor = [UIColor redColor].CGColor;
//    textField.layer.masksToBounds = YES;
//    textField.layer.cornerRadius = 3;
//    
//    [self.view addSubview:textField];
//    
//    UIButton *btm1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btm1 setTitle:@"回答" forState:UIControlStateNormal];
//    [btm1 setFrame:CGRectMake(10, CGRectGetMaxY(textField.frame), 100, 30)];
//    [btm1 setBackgroundColor:[UIColor redColor]];
//    [btm1 addTarget:self action:@selector(answer:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btm1];
//    UIButton *btm2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btm2 setTitle:@"改变问题" forState:UIControlStateNormal];
//    [btm2 setBackgroundImage:[UIImage imageNamed:@"arrow_gray_down"] forState:UIControlStateHighlighted];
//    [btm2 setFrame:CGRectMake(200, CGRectGetMaxY(textField.frame), 100, 30)];
//    [btm2 setBackgroundColor:[UIColor redColor]];
//    [btm2 addTarget:self action:@selector(changeAnswer:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btm2];
//    UIImage *image123  = [UIImage imageNamed:@"arrow_gray_down"];
//
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, image123.size.width, image123.size.height)];
//    imageview.image =image123;
//    [self.view addSubview:imageview];
    
    
    
}
//-(void)answer:(UIButton *)sender
//{
//
//    NSString *myanser = self.textField.text;
//    
//    NSString *message;
//    if ([myanser isEqualToString:[self.answer objectAtIndex:self.currentIndex]]) {
//        message = @"回答正确";
//    }else{
//        message = @"回答错误";
//    }
//    
//    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"title" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    
//}


//-(void)changeAnswer:(UIButton *)sender
//{
//
//    
//    int randNum = rand() % 3; //create the random number.
//    
//    self.currentIndex = randNum;
//
//    
////    
////    if (self.currentIndex == [self.questions count]) {
////        self.currentIndex = 0;
////    }
//    self.questionLabel.text = [self.questions objectAtIndex:self.currentIndex];
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)pushSchoollist:(id)sender
{
//    
//    if(![_answerField.text isEqualToString:[self.answer objectAtIndex:_countAnswer]])
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"回答错误" message:@"您的回答错误请重新回答" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        
//        return;
//    }
//    else {
    
        RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
        [self.navigationController pushViewController:registerViewController animated:YES];
    //}
    
}


-(void)refreshQuestion:(id)sender
{
    //NSLog(@"change a question");
    
    int randNum = rand() % 3; //create the random number.
    
    self.currentIndex = randNum;
    
//    if (_countAnswer+1 == [self.questions count]) {
//        _countAnswer = 0;
//    }
//    else {
//        _countAnswer++;
//    }
    
    _questionLabel.text = [self.questions objectAtIndex:self.currentIndex];
    _hintLabel.text = [hints objectAtIndex:self.currentIndex];
    // NSLog(@"_questionField.%@",_questionField.text);
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField123
{
    CGFloat extraHeight = 170;
 
    [scrollview setContentOffset:CGPointMake(0,textField123.center.y-extraHeight) animated:YES];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField123
{
    
    if (textField123 == _answerField)
        [_answerField resignFirstResponder];
    
    [self.scrollview setContentOffset:CGPointMake(0,-55) animated:YES];
    return YES;
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
