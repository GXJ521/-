//
//  RDRegisterViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDRegisterViewController.h"
#import "RDUserloginMode.h"
@interface RDRegisterViewController ()<UITextFieldDelegate>
{
    CustomLabel *secondLabel;
    CustomLabel *buttonLabel;
}
@end

@implementation RDRegisterViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self creatUI];
     self.titleString = @"注册";
}
-(void)creatUI{

    UIView *orderView =[[UIView alloc]initWithFrame:CGRectMake(0,0 , SCREENWIDTH, SCREENHEIGHT+200)];
    orderView.backgroundColor =backGroundColor;
    [self.view addSubview:orderView];
    //
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(20, 24, SCREENWIDTH-40, 24+100+44+13+44+13+44+13+44+21+12+22+14)];
    [self.view addSubview:backView];
    
    self.completeButton =[[CustomButton alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(backView.frame)+20, SCREENWIDTH-120, 90) andSize:16 andTextColor:[UIColor whiteColor] andTitle:@"注册"];
    self.completeButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 20, 0);
    self.completeButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.completeButton setBackgroundImage:[UIImage imageNamed:@"登录1"] forState:UIControlStateNormal];
    
    [self.completeButton setBackgroundImage:[UIImage imageNamed:@"登录-按下"] forState:UIControlStateHighlighted];
    
    [self.completeButton addTarget:self action:@selector(completeRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.completeButton];
    
    
    UIImageView *BackImgView =[[UIImageView alloc]initWithFrame:CGRectMake((backView.frame.size.width-325)/2, 0,325, 24+100+44+13+44+13+44+13+44+21+12+22+14)];
    BackImgView.image =[UIImage imageNamed:@"注册背景"];
    BackImgView.userInteractionEnabled =YES;
    [backView addSubview:BackImgView];
    //手机号码
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(25, 95, BackImgView.frame.size.width - 50, 44)];
    view1.layer.cornerRadius = 22;
    view1.backgroundColor = backGroundColor;
    [BackImgView addSubview:view1];
    
    self.phoneNumberTextField=[[CustomTextFiled alloc]initWithFrame:CGRectMake(25, (44-20)/2, view1.frame.size.width-50, 20) andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1) andBackGroundColor:backGroundColor andPlaceolder:@"手机号码"];
    self.phoneNumberTextField.delegate=self;
    self.phoneNumberTextField.tag=1000;
    self.phoneNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    [view1 addSubview:self.phoneNumberTextField];
    //验证码
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(view1.frame)+13, BackImgView.frame.size.width - 50, 44)];
    view2.layer.cornerRadius = 22;
    view2.backgroundColor = backGroundColor;
    [BackImgView addSubview:view2];
    
    self.vertifictionCodeTextField=[[CustomTextFiled alloc]initWithFrame:CGRectMake(25,(44-20)/2,view2.frame.size.width-50, 20) andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1) andBackGroundColor:backGroundColor andPlaceolder:@"请输入姓名"];
    [view2 addSubview:self.vertifictionCodeTextField];
    
    secondLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(8, 5, 40, 35) andSize:16 andTextColor:RGBACOLOR(255, 169, 65, 1)];
    buttonLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(secondLabel.frame.size.width+secondLabel.frame.origin.x, 5, 55, 35) andSize:12 andTextColor:[UIColor whiteColor]];
    [self.getVeritifiyCodeButton addSubview:secondLabel];
    [self.getVeritifiyCodeButton addSubview:buttonLabel];
    
    
    //密码
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(view2.frame)+13, BackImgView.frame.size.width - 50, 44)];
    view4.layer.cornerRadius = 22;
    view4.backgroundColor = backGroundColor;
    [BackImgView addSubview:view4];
    self.passwordTextFild=[[CustomTextFiled alloc]initWithFrame:CGRectMake(25, (44-20)/2, view1.frame.size.width-50, 20) andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1)andBackGroundColor:backGroundColor andPlaceolder:@"密码  (6-16位数字或字母)"];
    self.passwordTextFild.secureTextEntry = YES;
    self.passwordTextFild.keyboardType = UIKeyboardTypeDefault;
    [view4 addSubview:self.passwordTextFild];
    
    //验证码
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(view4.frame)+13, BackImgView.frame.size.width - 50, 44)];
    view5.layer.cornerRadius = 22;
    view5.backgroundColor = backGroundColor;
    [BackImgView addSubview:view5];
    self.codeTextFiled=[[CustomTextFiled alloc]initWithFrame:CGRectMake(25, (44-20)/2, view1.frame.size.width-50, 20) andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1)andBackGroundColor:backGroundColor andPlaceolder:@"验证码"];
    self.codeTextFiled.secureTextEntry = YES;
    self.codeTextFiled.keyboardType = UIKeyboardTypeDefault;
    [view5 addSubview:self.codeTextFiled];
    
    
    
}
#pragma mark -注册
- (void)completeRegister{

     if (self.phoneNumberTextField.text.length <1)
    {
        [MBProgressHUD showError:@"请输入手机号码" toView:self.view];
    }
    else if (self.passwordTextFild.text.length < 3)
    {
        [MBProgressHUD showError:@"密码（3-10）位数字或字母" toView:self.view];
    
    }
    else{
    
    [RDUserloginMode getUserRegisterBlock:^(BOOL result, int code, NSDictionary *returnData, NSString *faildMessage, NSError *error) {
        
        if (code==0000) {
            
            [MBProgressHUD showSuccess:@"注册成功" toView:
             self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        
            
        }
        else{
            
            [MBProgressHUD showError:[returnData objectForKey:@"mes"] toView:self.view];
            
        }
        
    } withParams:@{@"phone":self.phoneNumberTextField.text,@"name":self.vertifictionCodeTextField.text,@"pwd":self.passwordTextFild.text,@"validCode":self.codeTextFiled.text}];
        
    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.phoneNumberTextField  resignFirstResponder];
    [self.passwordTextFild resignFirstResponder];
    [self.vertifictionCodeTextField resignFirstResponder];
    [self.codeTextFiled resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout=NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
