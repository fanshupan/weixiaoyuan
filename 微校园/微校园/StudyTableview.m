//
//  StudyTableview.m
//  微校园
//
//  Created by wuming on 14/11/1.
//  Copyright (c) 2014年 wu ming. All rights reserved.
//

#import "StudyTableview.h"

@interface StudyTableview ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation StudyTableview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setScrollEnabled:NO];
    //self.tableView.layer.masksToBounds = YES;
    
    
    [self.view addSubview:self.tableView];
}





-(void)viewWillAppear:(BOOL)animated{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
    
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"com here: %ld",(long)indexPath.row);
    
    
    
    
    static NSString *CellIdentifier1 = @"Cellidentifier1";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
    if (cell1==nil){
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 30)];
        label1.tag = 1;
        [cell1.contentView addSubview:label1];
    }

    UILabel *tempLabel = (UILabel *)[cell1.contentView viewWithTag:1];
    if (indexPath.row == 0) {
        tempLabel.text = @"ffff";
    }
    else if (indexPath.row == 1)
    {
        tempLabel.text = @"gggg";
    }
    else{
        tempLabel.text = @"ppp";
    }

    
       // cell1.textLabel.text = @"123";

    return cell1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
}



@end
