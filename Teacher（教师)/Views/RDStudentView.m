


//
//  RDStudentView.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDStudentView.h"

@implementation RDStudentView

//初始化本视图
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}
//初始化表格
- (UITableView *)tableView
{
    if (!_tableView)
    {
       _tableView=[[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}
@end
