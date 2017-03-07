



//
//  RDTeacherMode.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDTeacherMode.h"

@implementation RDTeacherMode
+ (void)getStudentInfoListWithBlock:(void(^)(BOOL result, NSArray *studentInfoList,NSString *failedMessage,NSError *error))block withParams:(NSDictionary *)dict{

    [RDApiClient getRequestWithCacheUrl:@"" withParams:dict cacheData:nil isCache:YES successBlock:^(NSDictionary *returnData) {
   
        NSLog(@"********%@",returnData);
        
        if ([[returnData objectForKey:@"code"]intValue] == 0)
        {
            NSMutableArray *StudentList = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *resultdataMap = [returnData objectForKey:@"dataMap"];
            NSDictionary *ResumePage = [resultdataMap objectForKey:@"pageList"];
            NSArray *dataListArr = [ResumePage objectForKey:@"dataList"];
            for (NSDictionary *dict in dataListArr)
            {
                RDStudentInfoMode*studentinfoModel = [RDStudentInfoMode yy_modelWithJSON:dict];
                
                [StudentList addObject:studentinfoModel];
                
                
            }
            if (block)
            {
                block(YES, StudentList ,nil, nil);
            }
        }
        else
        {
            if (block)
            {
                block(NO, nil,[returnData objectForKey:@"msg"], nil);
            }
        }
        
        
    } failureBlock:^(NSError *error, NSDictionary *returnData) {
        
        if (returnData) {
            
            if ([[returnData objectForKey:@"code"]intValue] == 0)
            {
                NSMutableArray *ResumeList = [NSMutableArray arrayWithCapacity:0];
                NSDictionary *resultdataMap = [returnData objectForKey:@"dataMap"];
                NSDictionary *ResumePage = [resultdataMap objectForKey:@"pageList"];
                NSArray *dataListArr = [ResumePage objectForKey:@"dataList"];
                for (NSDictionary *dict in dataListArr)
                {
                    RDStudentInfoMode *studentinfoModel = [RDStudentInfoMode yy_modelWithJSON:dict];
                    
                    [ResumeList addObject:studentinfoModel];
                    
                    
                }
                if (block)
                {
                    block(YES, ResumeList,nil, nil);
                }
            }
            else
            {
                if (block)
                {
                    block(NO, nil,[returnData objectForKey:@"msg"], nil);
                }
            }
            
            
        }
        
    }];

}
@end
