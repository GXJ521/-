//
//  CustomTextFiled.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "CustomTextFiled.h"

@implementation CustomTextFiled

- (CustomTextFiled *)initWithFrame:(CGRect)frame andTextSize:(CGFloat)size
                      andTextColor:(UIColor *)textColor
                andBackGroundColor:(UIColor *)backGroudColor
                     andPlaceolder:(NSString *)placeholder
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.font=[UIFont systemFontOfSize:size];
        self.textColor=textColor;
         self.backgroundColor=backGroudColor;
        self.placeholder=placeholder;
    }
    return self;
}

@end
