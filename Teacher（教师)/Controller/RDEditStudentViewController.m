//
//  RDEditStudentViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/28.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDEditStudentViewController.h"
#import "RDAddAndEditView.h"
#import "ZHPickView.h"
@interface RDEditStudentViewController ()<ZHPickViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    RDAddAndEditView *AddView;
    ZHPickView *datePicker;
    UIImage *headImage;
    NSString *imageName;//图片名
    NSString *timeSp ;

}
@property (nonatomic,strong)UIBarButtonItem *right;//导航条右按钮
@property (nonatomic,strong) NSData *ImageData;

@end

@implementation RDEditStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleString =@"编辑学生信息";
    [self rightButton];
    [self initView];
}

-(void)initView{
    
    AddView=[[RDAddAndEditView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:AddView];
    [AddView.manButton addTarget:self action:@selector(manButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    AddView.nameTextFiled.text =self.studentMode.name;
    
        
        if (self.studentMode.sex==0) {
            
            AddView.manButton.selected = NO;
            AddView.womanButton.selected = YES;
        }
        else{

            AddView.womanButton.selected = NO;
            AddView.manButton.selected = YES;

        }
    
    if (self.studentMode.entrance_time) {
        
        NSString *str =self.studentMode.entrance_time;
        NSTimeInterval time=[str doubleValue]+28800;
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
        [AddView.chooseDateButton setTitle:currentDateStr forState:UIControlStateNormal] ;
    }
    if (self.studentMode.headImage)
    {
        [AddView.headImageButton sd_setImageWithURL:self.studentMode.headImage forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认头像"]];
        
    }
    else
    {
        
        [AddView.headImageButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    }
    
    if (self.studentMode.entrance_time) {
        NSString *time = self.studentMode.entrance_time;
        [AddView.chooseDateButton setTitle:[time timeStringChangeString:time]  forState:UIControlStateNormal];
    }
    [AddView.womanButton addTarget:self action:@selector(womanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [AddView.chooseDateButton addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    AddView.headImageButton.layer.cornerRadius = 50;
    AddView.headImageButton.layer.masksToBounds =YES;
    [AddView.headImageButton addTarget:self action:@selector(headImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (UIBarButtonItem *)rightButton
{
    if (!_right)
    {
        _right =[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
        _right.tintColor =ThemeBluecolor;
        self.navigationItem.rightBarButtonItem=_right;
    }
    return _right;
}
- (void)headImageButtonClick:(UIButton *)sender
{
    //    [scrollView endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}
- (void)manButtonClick:(UIButton *)sender
{
    AddView.manButton.selected = YES;
    AddView.womanButton.selected = NO;
}

- (void)womanButtonClick:(UIButton *)sender
{
    AddView.manButton.selected = NO;
    AddView.womanButton.selected = YES;
}

-(void)chooseDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date;
    date =[formatter dateFromString:@"1990年01月01日"];
    datePicker=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    datePicker.tintColor =ThemeBluecolor;
    datePicker.delegate = self;
    [datePicker show];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    if (buttonIndex == 0)
    {
        // 相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        // 相册
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        }
        
        picker.editing = YES;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
}

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString resultID:(NSString *)resultID{
    
    NSLog(@"=========%@",resultString);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* inputDate = [inputFormatter dateFromString:resultString];
    
    NSLog(@"%@",inputDate);
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:inputDate];
    NSDate *localeDate = [inputDate  dateByAddingTimeInterval: interval];
    timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    NSLog(@"========%@",timeSp);
    [[NSUserDefaults standardUserDefaults]setObject:timeSp forKey:@"time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [AddView.chooseDateButton setTitle:resultString forState:UIControlStateNormal];
    [AddView.chooseDateButton setTitleColor:THEMECOLOR forState:UIControlStateNormal];
     AddView.chooseDateButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
}
#pragma mark -------------UIImagePickerControllerDelegate-------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [AddView.headImageButton setImage:[info objectForKey:UIImagePickerControllerEditedImage] forState:UIControlStateNormal];

    headImage = [info objectForKey:
                 UIImagePickerControllerEditedImage];
    NSLog(@"=-----%@",headImage);
    
    [self performSelector:@selector(saveImage:) withObject:headImage afterDelay:0.1];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)saveImage:(UIImage *)image {
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // 图片名
    imageName = [NSString stringWithFormat:@"%@.jpg", [[NSUUID UUID] UUIDString]];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    [UIImageJPEGRepresentation(image,0.5)writeToFile:imageFilePath atomically:YES];
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];
    //读取图片文件
    self.ImageData =UIImagePNGRepresentation(selfPhoto);
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [datePicker removeFromSuperview];
    
}


- (void)editClick{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:AddView.nameTextFiled.text forKey:@"name"];

    if (AddView.manButton.isSelected)
    {
        [dict setObject:@"1" forKey:@"sex"];
    }
    else if (AddView.womanButton.isSelected)
    {
        [dict setObject:@"0" forKey:@"sex"];
    }
    if (AddView.chooseDateButton.currentTitle.length && ![AddView.chooseDateButton.currentTitle isEqualToString:@"请选择日期"])
    {
        if (self.studentMode.entrance_time.length>0) {
            [dict setObject:self.studentMode.entrance_time forKey:@"entranceTime"];
            
        }else{
            [dict setObject:timeSp forKey:@"entranceTime"];
        }
        
    }
    [dict setObject:self.studentMode.teacher_id forKey:@"teacherId"];
    [dict setObject:self.studentMode.student_id forKey:@"id"];
    if (self.ImageData) {
        [RDStudentInfoMode uploadImageWithBlock:^(BOOL result, NSString *failedMessage, NSError *error) {
            
            if (result) {
                
                [MBProgressHUD showMessag:@"保存成功" toView:self.view];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadTable" object:nil];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
            }else{
                
                [MBProgressHUD showError:@"保存失败" toView:self.view];
                
            }
        } withParams:dict imageData:self.ImageData imageName:imageName];
    }else{
    
        if (self.studentMode.headImage) {
            [dict setObject:self.studentMode.headImage forKey:@"headImage"];
           
        }
        [RDApiClient postRequestWithUrl:@"stu/saveStudent" withParams:dict successBlock:^(NSDictionary *returnData) {
            if ([[returnData objectForKey:@"code" ]intValue]==0000) {
                
                [MBProgressHUD showMessag:@"保存成功" toView:self.view];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadTable" object:nil];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }else{
                
                [MBProgressHUD showError:@"保存失败" toView:self.view];
                
                
            }
            
        } failureBlock:^(NSError *error) {
            
        }];

       
    
    }

    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [AddView.nameTextFiled resignFirstResponder];
}

@end
