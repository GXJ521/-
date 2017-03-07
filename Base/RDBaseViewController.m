


//
//  RDBaseViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDBaseViewController.h"

@interface RDBaseViewController ()
{
    UIButton *backButton;
}
@end

@implementation RDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    self.view.backgroundColor =[UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(0, 8, 45, 34);
    [backButton setImage:[UIImage imageNamed:@"返回箭头"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backButton];
    
    //    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
-(void)setTitleString:(NSString *)titleString
{
    CustomLabel *titleLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40) andSize:19 andTextColor:COLOR(51, 51, 51)];
    titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    titleLabel.text=titleString;
    self.navigationItem.titleView=titleLabel;
}
- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
