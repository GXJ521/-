

//
//  RDLoginViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDLoginViewController.h"
#import "RDRegisterViewController.h"
#import "RDTeacherViewController.h"
#import "RDUserloginMode.h"
@interface RDLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) CustomButton *loginButton;
@property (nonatomic,strong)CustomButton *registerButton;
@property (nonatomic,strong)CustomButton *resetPasswordButton;
@end

@implementation RDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomLabel *titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44) andSize:18.0f andTextColor:COLOR(51, 51, 51)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
    titleLabel.text=@"登录";
    self.navigationItem.titleView=titleLabel;
    [self initView];
    self.view.backgroundColor =backGroundColor;
    
    
    
}
- (void)initView{
    
    UIView *orderView =[[UIView alloc]initWithFrame:CGRectMake(0,0 , SCREENWIDTH, SCREENHEIGHT +100)];
    orderView.backgroundColor =backGroundColor;
    [self.view addSubview:orderView];
    
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(20, 23,SCREENWIDTH-40 ,23+100+44+21+44+23+13+21)];
    backView.backgroundColor =backGroundColor;
    [self.view addSubview:backView];
    
    self.loginButton =[[CustomButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - 250)/2, CGRectGetMaxY(backView.frame)+5, 250, 90) andSize:16 andTextColor:[UIColor whiteColor] andBackgroudColor:[UIColor clearColor] andTitle:@"登录"];
    self.loginButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 20, 0);
    self.loginButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"登录1"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"登录-按下"] forState:UIControlStateHighlighted];
    [self.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    UIImageView *BackImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,backView.frame.size.width, 23+100+44+21+44+23+13+21)];
    BackImgView.image =[UIImage imageNamed:@"登录背景"];
    BackImgView.userInteractionEnabled =YES;
    [backView addSubview:BackImgView];
    //view1
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(25, 100, BackImgView.frame.size.width - 50, 44)];
    view1.layer.cornerRadius = 22;
    view1.backgroundColor = backGroundColor;
    //    view1.backgroundColor =[UIColor yellowColor];
    [BackImgView addSubview:view1];
    
    UIImageView *img1 =[[UIImageView alloc]initWithFrame:CGRectMake(23,11,20,20)];
    img1.image =[UIImage imageNamed:@"账号"];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.userInteractionEnabled =YES;
    [view1 addSubview:img1];
    
    //手机号码
    self.userAccountTextField = [[CustomTextFiled alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img1.frame) + 18, 11, view1.frame.size.width - (CGRectGetMaxX(img1.frame) + 18), 20)andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1)andBackGroundColor:backGroundColor andPlaceolder:@"手机号码"];
    self.userAccountTextField.tag = 1001;
    self.userAccountTextField.delegate = self;
    [view1 addSubview:self.userAccountTextField];
    
    //view2
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(view1.frame)+21, BackImgView.frame.size.width - 50, 44)];
    view2.layer.cornerRadius = 22;
    view2.backgroundColor = backGroundColor;
    [BackImgView addSubview:view2];
    
    UIImageView *img2 =[[UIImageView alloc]initWithFrame:CGRectMake(23,11,20,20)];
    img2.image =[UIImage imageNamed:@"密码1"];
    img2.userInteractionEnabled =YES;
    img2.contentMode = UIViewContentModeScaleAspectFit;
    [view2 addSubview:img2];
    
    //密码框
    self.userPasswordTextField = [[CustomTextFiled alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img2.frame) + 18, 11, view1.frame.size.width - (CGRectGetMaxX(img2.frame) + 18), 20)andTextSize:12 andTextColor:RGBACOLOR(51, 51, 51, 1) andBackGroundColor:backGroundColor andPlaceolder:@"6-16位数字或字母"];
    self.userPasswordTextField.secureTextEntry = YES;
    self.userPasswordTextField.delegate = self;
    [view2 addSubview:self.userPasswordTextField ];
    
    
    //注册账号
    self.registerButton = [[CustomButton alloc]initWithFrame:CGRectMake(backView.frame.size.width - 50 - 48, CGRectGetMaxY(view2.frame)+23, 50, 24) andSize:12 andTextColor:COLOR(55, 211, 203) andBackgroudColor:[UIColor clearColor] andTitle:@"注册账号"];
    [self.view addSubview:self.registerButton];
    [self.registerButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [BackImgView addSubview:self.registerButton];
    
    
}

#pragma mark -登录
- (void)loginButtonClick:(UIButton *)sender{
    
    if (self.userAccountTextField.text.length==0) {
    
        CustomAlertView *alertView=[[CustomAlertView alloc]initWithTitle:@"请输入账户名或手机号码" andMessage:nil andCancleButtonTitle:@"确定" andOtherButtonTitle:nil andButtonCount:1];
        [alertView showView:self.view withBlock:^(NSInteger buttonTag) {
            
        }];
        
    }
    else if (self.userPasswordTextField.text.length ==0){
    
        CustomAlertView *alertView=[[CustomAlertView alloc]initWithTitle:@"请输入登陆密码" andMessage:nil andCancleButtonTitle:@"确定" andOtherButtonTitle:nil andButtonCount:1];
        [alertView showView:self.view withBlock:^(NSInteger buttonTag) {
            
        }];
    }else{
    
    [RDUserloginMode getUserLoginBlock:^(BOOL result, int code, NSDictionary *returnData, NSString *faildMessage, NSError *error) {
        
        
        if ([[returnData objectForKey:@"code"]intValue]==0000) {
            
            [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *teacherid=  [[returnData objectForKey:@"obj"]objectForKey:@"id"];
                [[NSUserDefaults standardUserDefaults] setObject:teacherid forKey:@"teacherid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                RDTeacherViewController *teacher =[[RDTeacherViewController alloc] init];
                [self.navigationController pushViewController:teacher animated:YES];
            });
            
            
        }else if([[returnData objectForKey:@"code"]intValue]==0005){
            
            [MBProgressHUD showError:[returnData objectForKey:@"mes"] toView:self.view];
            
        }else if ([[returnData objectForKey:@"code"]intValue]==0001){
            
            [MBProgressHUD showError:[returnData objectForKey:@"mes"] toView:self.view];
            
        }
        
    } withParams:@{@"phone":self.userAccountTextField.text,@"pwd":self.userPasswordTextField.text}];
    }
}
#pragma mark -注册
- (void)registButtonClick:(UIButton *)sender
{
    RDRegisterViewController *registerViewController=[[RDRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [_userAccountTextField resignFirstResponder];
    [_userPasswordTextField resignFirstResponder];
}


@end
