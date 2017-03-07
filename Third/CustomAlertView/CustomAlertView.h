//
//  CustomAlertView.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonActionBlock)(NSInteger buttonTag);

@interface CustomAlertView : UIView
@property (nonatomic, assign) float   backViewAlpha;
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIColor * messageColor;
@property (nonatomic, strong) UIColor * cancelButtonBackgroundColor;
@property (nonatomic, strong) UIColor * cancelButtonTitleColor;
@property (nonatomic, strong) UIColor * otherButtonBackgroundColor;
@property (nonatomic, strong) UIColor * otherButtonTitleColor;
@property (nonatomic, strong) UIImageView * backGroundImage;
@property (nonatomic, assign) BOOL    isAnimate;

@property (nonatomic, strong) CustomLabel *titleLabel;
@property (nonatomic, strong) CustomLabel *messageLabel;
@property (nonatomic, strong) CustomButton *cancleButton;
@property (nonatomic, strong) CustomButton *otherButton;
//@property (nonatomic, strong) CustomSecondButton *dismissButton;
@property (nonatomic, copy) buttonActionBlock actionWithButton;


@property (nonatomic, strong) UIView *backView;
- (instancetype)initWithTitle:(NSString*)title andMessage:(NSString *)message andCancleButtonTitle:(NSString *)cancleButtonTitle andOtherButtonTitle:(NSString *)otherTitle andButtonCount:(NSInteger)buttonCount;
- (void)showView:(UIView*)view withBlock:(buttonActionBlock)blockAction;
@end
