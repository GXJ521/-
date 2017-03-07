
//
//  RDTeacherViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDTeacherViewController.h"
#import "RDStudentView.h"
#import "RDStudentTableViewCell.h"
#import "RDAddStudentInfoViewController.h"
#import "RDEditStudentViewController.h"
#import "RDStudentInfoMode.h"
#import "MJRefreshHeader.h"
@interface RDTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     RDStudentView *StudetTableView;
    UIView *noView;
     int pn;

}
@property (nonatomic,strong)UIBarButtonItem *right;//导航条右按钮
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSArray *arr;

@end

@implementation RDTeacherViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleString = @"学生列表";
    self.dataArray =[NSMutableArray array];
    [self rightButton];
    StudetTableView=[[RDStudentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
    self.view=StudetTableView;
    StudetTableView.tableView.dataSource=self;
    StudetTableView.tableView.delegate=self;
    // 设置文字
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    StudetTableView.tableView.mj_header =header;
    StudetTableView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    // 设置了底部inset
     StudetTableView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
     StudetTableView.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData) name:@"reloadTable" object:nil];

    [self getData];
    
}

- (UIBarButtonItem *)rightButton
{
    if (!_right)
    {
        _right =[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickAdd)];
        _right.tintColor =ThemeBluecolor;
        self.navigationItem.rightBarButtonItem=_right;
    }
    return _right;
}
#pragma mark -添加学生信息界面
-(void)clickAdd{

    RDAddStudentInfoViewController *addStudentInfo =[[RDAddStudentInfoViewController alloc] init];
    [self.navigationController pushViewController:addStudentInfo animated:YES];
    
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellId=@"StudentTableViewCell";
    RDStudentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    if(cell==nil){
        cell=[[RDStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    RDStudentInfoMode *studentMode =self.dataArray[indexPath.row];
    [cell setContentWithJianli:studentMode];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 94;
}



- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    //删除
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        RDStudentInfoMode *mode =self.dataArray[indexPath.row];
        [RDApiClient getRequestWithUrl:@"stu/deleteStudent" withParams:@{@"id":mode.student_id} successBlock:^(NSDictionary *returnData) {
            
            NSLog(@"=======%@",returnData);
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failureBlock:^(NSError *error) {
            
        }];
    }];
    action1.backgroundColor = [UIColor redColor];
    //编辑
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑"handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        RDEditStudentViewController *editStudent =[[RDEditStudentViewController alloc] init];
        RDStudentInfoMode *studentMode =self.dataArray[indexPath.row];
        editStudent.studentMode =studentMode;
        [self.navigationController pushViewController:editStudent animated:YES];
        
        
    }];
    //置顶
    action2.backgroundColor =[UIColor purpleColor];    
    UITableViewRowAction *toTop = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataArray  exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];

        
    }];
    return@[action1,action2,toTop];
}
#pragma mark 获取数据
- (void)getData{
    
    pn = 1;
    NSString *teacherid =  [[NSUserDefaults standardUserDefaults]objectForKey:@"teacherid"];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:@(pn) forKey:@"pn"];
    [dict setObject:@"10" forKey:@"ps"];
    [dict setObject:teacherid forKey:@"id"];
    [MBProgressHUD showMessag:@"正在加载" toView:self.view];
    [RDStudentInfoMode getStudentInfoListWithBlock:^(BOOL result, NSArray *studentInfoList, NSString *failedMessage, NSError *error) {
        
        [StudetTableView.tableView.mj_header endRefreshing];
        
        if (result) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"=========%@",studentInfoList);
            pn++;
            self.dataArray = [NSMutableArray arrayWithArray:studentInfoList];
            
            if (self.dataArray.count)
            {
                noView.hidden = YES;
            }
            else
            {
                [noView removeFromSuperview];
                [self initNoView];
                noView.hidden = NO;
            }
            
            [StudetTableView.tableView reloadData];
            
        }else{
            
            [MBProgressHUD showError:failedMessage toView:self.view];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        
    } withParams:dict];
    
}
#pragma mark 上拉刷新
- (void)footerRefresh{
    
    
    NSString *teacherid =  [[NSUserDefaults standardUserDefaults]objectForKey:@"teacherid"];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:@(pn) forKey:@"pn"];
    [dict setObject:@"5" forKey:@"ps"];
    [dict setObject:teacherid forKey:@"id"];
    [RDStudentInfoMode getStudentInfoListWithBlock:^(BOOL result, NSArray *studentInfoList, NSString *failedMessage, NSError *error) {
        if (result) {
            NSLog(@"=========%@",studentInfoList);
            pn++;
            [self.dataArray addObjectsFromArray:studentInfoList];
            [StudetTableView.tableView reloadData];
            [StudetTableView.tableView.mj_footer endRefreshing];
            
        }else{
            
            [MBProgressHUD showError:failedMessage toView:self.view];
        }
        
    } withParams:dict];
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}
- (void)initNoView
{
    noView = [[UIView alloc] initWithFrame:CGRectMake(0, 63*SCREENWIDTH/375-20, SCREENWIDTH,StudetTableView.tableView.frame.size.height-40-63*SCREENWIDTH/375)];
    [StudetTableView.tableView addSubview:noView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-67, (noView.frame.size.height-135)/2, 135, 135)];
    imageView.image = [UIImage imageNamed:@"缺省图"];
    [noView addSubview:imageView];
    CustomLabel *label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height+20, SCREENWIDTH, 20) andSize:15.0f andTextColor:COLOR(51, 51, 51)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂无此类信息";
    [noView addSubview:label];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadTable" object:nil];
}
@end
