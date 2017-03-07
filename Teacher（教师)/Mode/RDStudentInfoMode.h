//
//  RDStudentInfoMode.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDStudentInfoMode : NSObject

//姓名
@property (nonatomic,copy) NSString *name;
//头像
@property (nonatomic,strong) NSURL *headImage;
//性别
@property (nonatomic,assign) int sex;
//日期
@property (nonatomic,strong) NSString *entrance_time;
//老师ID
@property (nonatomic,strong) NSString *student_id;
//学生ID
@property (nonatomic,strong) NSString *teacher_id;
+ (void)getStudentInfoListWithBlock:(void(^)(BOOL result, NSArray *studentInfoList,NSString *failedMessage,NSError *error))block withParams:(NSDictionary *)dict;
+ (void)uploadImageWithBlock:(void(^)(BOOL result, NSString *failedMessage,NSError *error))block withParams:(NSMutableDictionary *)dict imageData:(NSData *)imageData imageName:(NSString *)imageName;



@end
