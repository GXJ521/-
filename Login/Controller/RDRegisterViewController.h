//
//  RDRegisterViewController.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDBaseViewController.h"

@interface RDRegisterViewController : RDBaseViewController
@property (nonatomic, strong)CustomTextFiled *phoneNumberTextField;//电话
//@property (nonatomic, strong)CustomButton *nextStepButton;
@property (nonatomic, strong)NSString *phoneNumber;
@property (nonatomic, assign)NSInteger registerType;

@property (nonatomic, strong)CustomTextFiled *passwordTextFild;//密码
@property (nonatomic, strong)CustomTextFiled *vertifictionCodeTextField;//
@property (nonatomic, strong)CustomLabel *explainLabel;
@property (nonatomic, strong)CustomButton *completeButton;
@property (nonatomic, strong)CustomButton *getVeritifiyCodeButton;
@property (nonatomic,strong)CustomTextFiled *codeTextFiled;
@property (nonatomic, strong)CustomLabel *questionLabel;
@property (nonatomic, assign)NSInteger agreementType; //注册协议类型
@end
