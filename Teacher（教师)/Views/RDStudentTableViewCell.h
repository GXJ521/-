//
//  RDStudentTableViewCell.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDStudentInfoMode.h"
@interface RDStudentTableViewCell : UITableViewCell
//背景图片
@property (nonatomic, retain) UIImageView *backImageView;
//头像
@property (nonatomic, strong) UIImageView *studentHeaderImage;
//姓名
@property (nonatomic, strong) CustomLabel *nameLab;
//性别
@property (nonatomic, strong) CustomLabel *sexLab;
//日期
@property (nonatomic, strong) CustomLabel *dateLab;
-(void)setContentWithJianli:(RDStudentInfoMode *)mode;
@end
