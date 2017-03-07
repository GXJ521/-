//
//  RDUserloginMode.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDUserloginMode.h"

@implementation RDUserloginMode
+(void)getUserLoginBlock:(void(^)(BOOL result,  int code,NSDictionary *returnData, NSString *faildMessage, NSError *error))block withParams:(NSDictionary*)dict{

    [RDApiClient postRequestWithUrl:@"stu/login" withParams:dict successBlock:^(NSDictionary *returnData) {
        
        int code=[[returnData objectForKey:@"code"]intValue];
        
        if(block)
        {
            block(YES,code,returnData,nil,nil);
        }
        
    } failureBlock:^(NSError *error) {
        block(NO, 2, nil,@"网络不在家，出门兼职了", error);
        
    }];

}

+(void)getUserRegisterBlock:(void(^)(BOOL result, int code,NSDictionary *returnData, NSString *faildMessage, NSError *error))block withParams:(NSDictionary*)dict{
    
    [RDApiClient getRequestWithUrl:@"stu/register" withParams:dict successBlock:^(NSDictionary *returnData) {
        int code=[[returnData objectForKey:@"code"]intValue];
        if(block)
        {
            block(YES,code,returnData,nil,nil);
        }
    }
     
      failureBlock:^(NSError *error) {
        block(NO, 2, nil,@"网络不在家，出门兼职了", error);
                          
    }];
    
}
@end
