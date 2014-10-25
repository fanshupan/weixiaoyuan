//
//  ValidateViewController.m
//  微校园
//
//  Created by wuming on 14/10/25.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "ValidateViewController.h"

@interface ValidateViewController ()

@property (nonatomic,strong) NSMutableArray *questions;
@property (nonatomic,strong) NSMutableArray *answer;
@property (nonatomic,strong)    UITextField *textField;
@property (nonatomic,assign) int currentIndex;
@property (nonatomic,strong)    UILabel *questionLabel;
@end

@implementation ValidateViewController
@synthesize textField;
@synthesize questionLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"arrow_left"]];

    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"arrow_left"]];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 50, 50)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = item;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"右边" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(10000, 1000, 50, 50)];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = rightitem;

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.title = @"注册";
    self.currentIndex = 0;
    
    
    self.questions = [[NSMutableArray alloc] initWithObjects:@"1+1=",@"2+2=",@"3+3=", nil];
    self.answer = [[NSMutableArray alloc] initWithObjects:@"2",@"4",@"6", nil];
    
    
    questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 250, 20)];
    
    questionLabel.text = [self.questions objectAtIndex:self.currentIndex];
    
    [self.view addSubview:questionLabel];
    
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
   // textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Please Enter:";
    
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = [UIColor redColor].CGColor;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 3;
    
    [self.view addSubview:textField];
    
    UIButton *btm1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btm1 setTitle:@"回答" forState:UIControlStateNormal];
    [btm1 setFrame:CGRectMake(10, CGRectGetMaxY(textField.frame), 100, 30)];
    [btm1 setBackgroundColor:[UIColor redColor]];
    [btm1 addTarget:self action:@selector(answer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btm1];
    UIButton *btm2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btm2 setTitle:@"改变问题" forState:UIControlStateNormal];
    [btm2 setBackgroundImage:[UIImage imageNamed:@"arrow_gray_down"] forState:UIControlStateHighlighted];
    [btm2 setFrame:CGRectMake(200, CGRectGetMaxY(textField.frame), 100, 30)];
    [btm2 setBackgroundColor:[UIColor redColor]];
    [btm2 addTarget:self action:@selector(changeAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btm2];
    UIImage *image123  = [UIImage imageNamed:@"arrow_gray_down"];

    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, image123.size.width, image123.size.height)];
    imageview.image =image123;
    [self.view addSubview:imageview];
    
    
    
}
-(void)answer:(UIButton *)sender
{
    NSString *myanser = self.textField.text;
    
    NSString *message;
    if ([myanser isEqualToString:[self.answer objectAtIndex:self.currentIndex]]) {
        message = @"回答正确";
    }else{
        message = @"回答错误";
    }
    
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"title" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}


-(void)changeAnswer:(UIButton *)sender
{

    
    int randNum = rand() % 3; //create the random number.
    
    self.currentIndex = randNum;

    
//    
//    if (self.currentIndex == [self.questions count]) {
//        self.currentIndex = 0;
//    }
    self.questionLabel.text = [self.questions objectAtIndex:self.currentIndex];
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
