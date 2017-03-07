//
//  CustomButton.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomButton : UIButton
@property (nonatomic,strong) NSString *buttonID;
- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andBackgroudColor:(UIColor *)backGroundColor1 andTitle:(NSString *)title;
- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andTitle:(NSString *)title;
- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andTitle:(NSString *)title andButton:(NSString *)buttonID;
@end
