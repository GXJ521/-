



//
//  RDAddAndEditView.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/28.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDAddAndEditView.h"

@interface RDAddAndEditView ()

@end

@implementation RDAddAndEditView



- (UIImageView *)BackimageView{

    if (!_BackimageView) {
        
        _BackimageView =[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _BackimageView.image =[UIImage imageNamed:@"感恩节6_&_6b06186d-797b-4f5c-bbe6-d39d3a72a9f3"];
    }
    return _BackimageView;
    
}

- (UIButton *)headImageButton{
    
    if (!_headImageButton) {
        
        _headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headImageButton.frame =CGRectMake((SCREENWIDTH-100)/2, 80, 100, 100);
        [_headImageButton setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    }
    return _headImageButton;
}

- (CustomLabel *)nameLab{

    if (!_nameLab) {
    
         _nameLab = [[CustomLabel alloc] initWithFrame:CGRectMake(60, 200, 71, 44) andSize:18.0f andTextColor:[UIColor greenColor]];
         _nameLab.text = @"姓名";
        
    }
    return _nameLab;
}

- (CustomTextFiled *)nameTextFiled{

    if (!_nameTextFiled) {
        
        _nameTextFiled =[[CustomTextFiled alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLab.frame), 210, 200, 30) andTextSize:13 andTextColor:[UIColor greenColor] andBackGroundColor:[UIColor lightGrayColor] andPlaceolder:@"请输入姓名"];

    }

    return _nameTextFiled;
}
- (CustomLabel *)sexLab{
    
    if (!_sexLab) {
        
        _sexLab = [[CustomLabel alloc] initWithFrame:CGRectMake(60, 300, 71, 44) andSize:18.0f andTextColor:[UIColor greenColor]];
        _sexLab.text = @"性别";
        
    }
    return _sexLab;
}

- (UIButton *)manButton{

    if (!_manButton) {
        
        _manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _manButton.frame = CGRectMake(130, 313, 20, 20);
        _manButton.selected = YES;
        [_manButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_manButton setBackgroundImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateSelected];
    }
    return _manButton;
}
- (CustomLabel *)manLabel{

    if (!_manLabel) {
        _manLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(_manButton.frame.origin.x+_manButton.frame.size.width+10, _manButton.frame.origin.y+3, 15, 15) andSize:18 andTextColor:[UIColor greenColor]];
        _manLabel.text = @"男";
    }
    return _manLabel;
   
}
- (UIButton *)womanButton{

    if (!_womanButton) {
        _womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanButton.frame = CGRectMake(CGRectGetMaxX(_manLabel.frame)+50, _manLabel.frame.origin.y-2, 20, 20);
        [_womanButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_womanButton setBackgroundImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateSelected];
    }
    return _womanButton;
    
}
- (CustomLabel *)womanLabel{

    if (!_womanLabel) {
    
        _womanLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(_womanButton.frame.origin.x+_womanButton.frame.size.width+10, _manButton.frame.origin.y+3, 15, 15) andSize:18.0 andTextColor:[UIColor greenColor]];
        _womanLabel.text = @"女";
        
        
    }
    return _womanLabel;
}

- (CustomLabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(60, 410, 50, 15) andSize:18.0 andTextColor:[UIColor greenColor]];
        _dateLabel.text = @"日期";
        
    }
    return _dateLabel;
}

- (CustomButton *)chooseDateButton{

    if (!_chooseDateButton) {
        _chooseDateButton =[[CustomButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dateLabel.frame)+5, _manButton.frame.origin.y+80, 100, 50) andSize:15 andTextColor:[UIColor greenColor] andTitle:@"请选择日期"];
    }
    return _chooseDateButton;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =backGroundColor;
        [self addSubview:self.BackimageView];
        [self addSubview:self.nameLab];
        [self addSubview:self.nameTextFiled];
        [self addSubview:self.manButton];
        [self addSubview:self.manLabel];
        [self addSubview:self.womanButton];
        [self addSubview:self.womanLabel];
        [self addSubview:self.sexLab];
        [self addSubview:self.dateLabel];
        [self addSubview:self.chooseDateButton];
        [self addSubview:self.headImageButton];
        
    }
    
    return self;
    
}


@end
