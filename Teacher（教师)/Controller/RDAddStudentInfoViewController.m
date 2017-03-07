//
//  RDAddStudentInfoViewController.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/28.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDAddStudentInfoViewController.h"
#import "RDAddAndEditView.h"
#import "ZHPickView.h"
#import "RDStudentInfoMode.h"
@interface RDAddStudentInfoViewController ()<ZHPickViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    RDAddAndEditView *AddView;
    ZHPickView *datePicker;
    UIImage *headImage;
    NSString *imageName;//图片名
    NSString *timeSp ;
}
@property (nonatomic,strong)UIBarButtonItem *right;//导航条右按钮
@property (nonatomic,strong) NSData *ImageData;

@end

@implementation RDAddStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString =@"添加学生信息";
    [self rightButton];
    [self initView];
    
}

- (UIBarButtonItem *)rightButton
{
    if (!_right)
    {
        _right =[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
        _right.tintColor =ThemeBluecolor;
        self.navigationItem.rightBarButtonItem=_right;
    }
    return _right;
}
-(void)initView{

     AddView=[[RDAddAndEditView alloc] initWithFrame:[UIScreen mainScreen].bounds];
     [self.view addSubview:AddView];
     [AddView.manButton addTarget:self action:@selector(manButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [AddView.womanButton addTarget:self action:@selector(womanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [AddView.chooseDateButton addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
    [AddView.headImageButton addTarget:self action:@selector(headImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)headImageButtonClick:(UIButton *)sender
{
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
-(void)addClick
{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    if (AddView.manButton.isSelected)
    {
        [dict setObject:@"1" forKey:@"sex"];
    }
    else if (AddView.womanButton.isSelected)
    {
        [dict setObject:@"0" forKey:@"sex"];
    }
    [dict setObject:AddView.nameTextFiled.text forKey:@"name"];
    if (AddView.chooseDateButton.currentTitle.length && ![AddView.chooseDateButton.currentTitle isEqualToString:@"请选择日期"])
    {
        [dict setObject:timeSp forKey:@"entranceTime"];
    }
    NSString *teacherid =  [[NSUserDefaults standardUserDefaults]objectForKey:@"teacherid"];
    [dict setObject:teacherid forKey:@"teacherId"];    
    NSLog(@"============%@",dict);
    
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
    }
}
- (void)chooseDate
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

    
    if (pickView ==datePicker) {
        
        NSLog(@"======%@",resultString);
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate* inputDate = [inputFormatter dateFromString:resultString];
       
        NSLog(@"%@",inputDate);
        
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:inputDate];
        NSDate *localeDate = [inputDate  dateByAddingTimeInterval: interval];
        timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
        NSLog(@"========%@",timeSp);
        [AddView.chooseDateButton setTitle:resultString forState:UIControlStateNormal];
    }
 
    
    
}
#pragma mark -------------UIImagePickerControllerDelegate-------------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [AddView.nameTextFiled resignFirstResponder];
    [self setHiddenPickerView];

}
- (void)setHiddenPickerView {
    [datePicker removeFromSuperview];

}

@end
