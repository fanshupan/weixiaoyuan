//
//  popUpView.h
//  微校园
//
//  Created by wuming on 11/16/14.
//  Copyright (c) 2014 wu ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol popUpViewDelegate <NSObject>

-(void)didSelectIndex:(NSString *)collegeName;

@end

@interface popUpView : UIView<UITableViewDelegate,UITableViewDataSource>


-(instancetype)initWithFrame:(CGRect)frame;

-(id)initWithName:(CGRect)frame colleges:(NSArray *)colleges;//我们使用这个，传入Colleges这个数组，为什么传输组:因为我们要在tableview里面显示学院

-(instancetype)initWithKey:(NSString *)key;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,unsafe_unretained) id delegate;
@end
