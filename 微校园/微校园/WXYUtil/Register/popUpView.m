//
//  popUpView.m
//  微校园
//
//  Created by wuming on 11/16/14.
//  Copyright (c) 2014 wu ming. All rights reserved.
//

#import "popUpView.h"

@interface popUpView()

@property (nonatomic,strong) NSArray *myColleges;


@end

@implementation popUpView

-(id)initWithName:(CGRect)frame colleges:(NSArray *)colleges
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myColleges = colleges;

        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0 , self.frame.size.width, self.frame.size.height)];
        
        
        //_tableView  = [[UITableView alloc] initWithFrame:frame];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self addSubview:_tableView];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
         _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0 , self.frame.size.width, self.frame.size.height)];

        
        //_tableView  = [[UITableView alloc] initWithFrame:frame];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self addSubview:_tableView];

    }
    return self;
}

-(instancetype)initWithKey:(NSString *)key
{
    self = [super initWithFrame:CGRectMake(50, 100, 200, 200)];
    
    if (self) {
        
    }
    return self;
 
}

#pragma mark -Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.myColleges count];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier1 = @"Cellidentifier1";
    
    
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
    
        if (cell1==nil)
            
        {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
            label.tag = 1;
            [cell1.contentView addSubview:label];
        }
    
    UILabel *label = (UILabel *)[cell1.contentView viewWithTag:1];
    label.text = [self.myColleges objectAtIndex:indexPath.row];
    
    
        
        
        return cell1;
        
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"college name:%@",[self.myColleges objectAtIndex:indexPath.row]);
    [self.delegate didSelectIndex:[self.myColleges objectAtIndex:indexPath.row]];
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
