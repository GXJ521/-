

//
//  CustomButton.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andBackgroudColor:(UIColor *)backGroundColor1 andTitle:(NSString *)title{
    if(self =[super initWithFrame:frame]){
        
        self.titleLabel.font=[UIFont systemFontOfSize:size];
        self.backgroundColor=backGroundColor1;
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}
- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andTitle:(NSString *)title{

    
        if(self =[super initWithFrame:frame]){
            
            self.titleLabel.font=[UIFont systemFontOfSize:size];
            
            [self setTitleColor:textColor forState:UIControlStateNormal];
            
            [self setTitle:title forState:UIControlStateNormal];
        }
        return self;
}
- (CustomButton *)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor andTitle:(NSString *)title andButton:(NSString *)buttonID{
    if(self =[super initWithFrame:frame]){
        
        self.titleLabel.font=[UIFont systemFontOfSize:size];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.buttonID =buttonID;
        
    }
    return self;
}
@end
