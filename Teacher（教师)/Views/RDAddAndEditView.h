//
//  RDAddAndEditView.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/28.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDAddAndEditView : UIView
@property(nonatomic , strong)CustomLabel *nameLab;
@property(nonatomic , strong)CustomLabel *sexLab;
@property(nonatomic , strong)UIImageView *BackimageView;
@property(nonatomic , strong)CustomTextFiled *nameTextFiled;
@property(nonatomic , strong)UIButton *manButton;
@property(nonatomic , strong)CustomLabel *manLabel;
@property(nonatomic , strong)UIButton *womanButton;
@property(nonatomic , strong)CustomLabel *womanLabel;
@property(nonatomic , strong)CustomLabel *dateLabel;
@property(nonatomic , strong)CustomButton *chooseDateButton;
@property(nonatomic , strong)UIButton *headImageButton;
@end
