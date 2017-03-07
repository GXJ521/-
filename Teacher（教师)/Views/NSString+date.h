//
//  NSString+date.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/3/2.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (date)

+ (NSString *)timeStringChangeString:(NSString *)longlongtime;
- (NSString *)timeStringChangeString:(NSString *)longlongtime;
@end
