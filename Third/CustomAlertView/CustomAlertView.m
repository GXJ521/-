



//
//  CustomAlertView.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message andCancleButtonTitle:(NSString *)cancleButtonTitle andOtherButtonTitle:(NSString *)otherTitle andButtonCount:(NSInteger)buttonCount{
    self=[super init];
    if(self){
        
        [self setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    }
    [self creatViewWithTitle:title message:message cancleButtonTitle:cancleButtonTitle otherButtonTitle:otherTitle andButtonCount:buttonCount];
    return self;
}

- (void)creatViewWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)cancleButtonTitle otherButtonTitle:(NSString*) otherButtonTitle andButtonCount:(NSInteger)buttonCount{
    
    float width;
    float height;
    float imageHeight;
    width=244;
    height=290;
    imageHeight=140;
    
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake((SCREENWIDTH-width)/2, (SCREENHEIGHT-height)/2, width, height)];
    self.backView.layer.cornerRadius=17;
    self.backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backView];
    self.backGroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, imageHeight)];
    self.backGroundImage.image=[UIImage imageNamed:@"custom_alertview"];
    [self.backView addSubview:self.backGroundImage];

    self.titleLabel =[[CustomLabel alloc]initWithFrame:CGRectMake(15, self.backGroundImage.frame.size.height+self.backGroundImage.frame.origin.y+23, self.backView.frame.size.width-30, 60)andSize:16 andTextColor:THEMECOLOR];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.numberOfLines=0;
    [self.backView addSubview:self.titleLabel];
    
    [self.titleLabel setText:title];
    CGSize titleSize = [_titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(self.backView.frame.size.width-30, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleLabel.frame=CGRectMake(15, self.backGroundImage.frame.size.height+self.backGroundImage.frame.origin.y+23, self.backView.frame.size.width-30, titleSize.height);
    if(titleSize.height>60){
        height=titleSize.height-60+14+height;
        self.backView.frame=CGRectMake((SCREENWIDTH-width)/2, (SCREENHEIGHT-height)/2, width, height);
    }
    if(buttonCount==2){
        self.cancleButton =[[ CustomButton alloc]initWithFrame:CGRectMake(18, self.backView.frame.size.height-40-13, 92, 40) andSize:14 andTextColor:ThemeBluecolor andTitle:@""];
        self.cancleButton.layer.cornerRadius=4;
        self.cancleButton.layer.borderColor=ThemeBluecolor.CGColor;
        self.cancleButton.layer.borderWidth=1;
        self.cancleButton.tag=0;
        [self.cancleButton addTarget:self action:@selector(butttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.otherButton =[[CustomButton alloc]initWithFrame:CGRectMake(self.backView.frame.size.width-18-92, self.cancleButton.frame.origin.y, 92, 40) andSize:14 andTextColor:ThemeBluecolor andTitle:@""];
        self.otherButton.layer.cornerRadius=4;
        self.otherButton.layer.borderColor=ThemeBluecolor.CGColor;
        self.otherButton.layer.borderWidth=1;
        self.otherButton.tag=1;
        [self.otherButton addTarget:self action:@selector(butttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backView addSubview:self.cancleButton];
        [self.backView addSubview:self.otherButton];
    }
    else if(buttonCount==1){
        
        self.cancleButton =[[CustomButton alloc]initWithFrame:CGRectMake((self.backView.frame.size.width-184)/2, self.backView.frame.size.height-40-13, 184, 40) andSize:14 andTextColor:ThemeBluecolor andTitle:@""];
        self.cancleButton.layer.cornerRadius=4;
        self.cancleButton.layer.borderColor=ThemeBluecolor.CGColor;
        self.cancleButton.layer.borderWidth=1;
        self.cancleButton.tag=0;
        [self.cancleButton addTarget:self action:@selector(butttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.cancleButton];
    }
    
    [self.messageLabel setText:message];
    [self.cancleButton setTitle:cancleButtonTitle forState:UIControlStateNormal];
    [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
}


- (void)butttonClick:(UIButton*)button{
    if(self.actionWithButton) {
        self.actionWithButton(button.tag);
    }
    [self dismissButtonclick];
    
    
}
- (void)showView:(UIView *)view withBlock:(buttonActionBlock)blockAction{
    
    if (blockAction) {
        self.actionWithButton = blockAction;
    }
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [self setAlpha:0];
    [UIView animateWithDuration:_isAnimate?0.3:0 animations:^{
        [self setAlpha:1];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]];
        } completion:^(BOOL finished) {
        }];
    }];
    
}

- (void)dismissButtonclick{
    
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0]];
    [UIView animateWithDuration:_isAnimate?0.5:0 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self.layer addAnimation:[self rotation:_isAnimate?0.5:0 degree:0.5 direction:3 repeatCount:0] forKey:nil];
    
}
-( CABasicAnimation *)rotation:( float )dur degree:( float )degree direction:( int )direction repeatCount:( int )repeatCount
{
    CATransform3D rotationTransform = CATransform3DMakeRotation (degree, 0 , 0 , direction);
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform" ];
    animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    animation. duration   =  dur;
    animation. autoreverses = NO ;
    animation. cumulative = NO ;
    animation. fillMode = kCAFillModeForwards ;
    animation. repeatCount = repeatCount;
    animation. delegate = self ;
    return animation;
    
    
}




#pragma mark - config background alpha
- (void)setBackViewAlpha:(float)backViewAlpha {
    if (backViewAlpha) {
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:backViewAlpha]];
    }
}

#pragma mark - config titleColor
-(void)setTitleColor:(UIColor *)titleColor {
    if (titleColor) {
        [_titleLabel setTextColor:titleColor];
    }
}

#pragma mark - config messageColor
-(void)setMessageColor:(UIColor *)messageColor {
    if (messageColor) {
        [_messageLabel setTextColor:messageColor];
    }
}


@end
