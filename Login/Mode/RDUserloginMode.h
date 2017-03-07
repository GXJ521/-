//
//  RDUserloginMode.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDUserloginMode : NSObject
/**
 用户登录
 */

+(void)getUserLoginBlock:(void(^)(BOOL result,  int code,NSDictionary *returnData, NSString *faildMessage, NSError *error))block withParams:(NSDictionary*)dict;

/**
 用户注册
 */
+(void)getUserRegisterBlock:(void(^)(BOOL result, int code,NSDictionary *returnData, NSString *faildMessage, NSError *error))block withParams:(NSDictionary*)dict;

@end
