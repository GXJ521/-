//
//  RDNavigationController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDNavigationController.h"

@interface RDNavigationController ()

@end

@implementation RDNavigationController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage=[[UIImage alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent=NO;
    //设置Navi 颜色
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationBar setTitleTextAttributes:titleBarAttributes];}

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
