//
//  CustomLabel.m
//  ejianzhi
//
//  Created by 小哥 on 15/10/28.
//  Copyright © 2015年 Studio Of Spicy Hot. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

-(instancetype)initWithFrame:(CGRect)frame andSize:(float)size andTextColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.font = [UIFont systemFontOfSize:size];
//        self.font = [UIFont fontWithName:[FontSingle shareFontSingle].pingfangsc_regular size:size];
        self.textColor = textColor;
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
