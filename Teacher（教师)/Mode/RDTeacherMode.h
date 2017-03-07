//
//  RDTeacherMode.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDStudentInfoMode.h"
@interface RDTeacherMode : NSObject
/**
 获取学生的信息
 */
//+ (void)getStudentInfoListWithBlock:(void(^)(BOOL result, NSArray *studentInfoList,NSString *failedMessage,NSError *error))block withParams:(NSDictionary *)dict;
@end
