
//
//  RDStudentTableViewCell.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDStudentTableViewCell.h"

@implementation RDStudentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        self.backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 94)];
        self.backImageView.image=[[UIImage imageNamed:@"forthViewBackImage"]stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        [self.contentView addSubview:self.backImageView];
        self.studentHeaderImage =[[UIImageView alloc] initWithFrame:CGRectMake(21, 20, 55, 55)];
        self.studentHeaderImage.layer.masksToBounds=YES;
        self.studentHeaderImage.layer.cornerRadius=27.5;
        [self.contentView addSubview:self.studentHeaderImage];
        
        
        self.nameLab =[[CustomLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.studentHeaderImage.frame)+15, 23, 200, 20) andSize:15 andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.nameLab];
        
        self.sexLab =[[CustomLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.studentHeaderImage.frame)+15, CGRectGetMaxY(self.nameLab.frame)+20, 50, 20) andSize:14 andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.sexLab];
        
        self.dateLab =[[CustomLabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100,CGRectGetMaxY(self.nameLab.frame) , 100, 15) andSize:15 andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.dateLab];
        
        
    }
    return self;
    
}
-(void)setContentWithJianli:(RDStudentInfoMode *)mode
{
    

        
   [self.studentHeaderImage sd_setImageWithURL:mode.headImage placeholderImage:[UIImage imageNamed:@"默认头像"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
    
    if (mode.name) {
        
        self.nameLab.text =mode.name;
    }
    if (mode.sex==0) {
        self.sexLab.text =@"女";
    }
    else{
        
        self.sexLab.text =@"男";
    }
    
   
    if (mode.entrance_time) {
        
    //时间戳
        
        self.dateLab.text =[NSString timeStringChangeString:mode.entrance_time];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
