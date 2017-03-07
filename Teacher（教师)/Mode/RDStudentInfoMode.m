



//
//  RDStudentInfoMode.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDStudentInfoMode.h"

@implementation RDStudentInfoMode

+ (void)getStudentInfoListWithBlock:(void(^)(BOOL result, NSArray *studentInfoList,NSString *failedMessage,NSError *error))block withParams:(NSDictionary *)dict{
    
    [RDApiClient getRequestWithCacheUrl:@"http://192.168.6.180:8088/ElangsInterface/stu/queryPageStu" withParams:dict cacheData:nil isCache:YES successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"=========%@",returnData);
        
        if ([[returnData objectForKey:@"code"]intValue] == 0000)
        {
            
            NSDictionary *Studentdic = [returnData objectForKey:@"obj"];

            NSMutableArray * StudentList1 =[Studentdic objectForKey:@"list"];
            
            NSLog(@"%@",StudentList1);
            
            NSMutableArray *arr =[NSMutableArray array];
            
            for (NSDictionary *dict in StudentList1)
            {
                
                RDStudentInfoMode*studentinfoModel = [RDStudentInfoMode yy_modelWithJSON:dict];
                [arr addObject:studentinfoModel];
                
            }
            if (block)
            {
                block(YES, arr ,nil, nil);
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
            
            NSDictionary *Studentdic = [returnData objectForKey:@"obj"];
            
            NSMutableArray * StudentList1 =[Studentdic objectForKey:@"list"];
            
            NSLog(@"%@",StudentList1);
            
            NSMutableArray *arr =[NSMutableArray array];
            
            for (NSDictionary *dict in StudentList1)
            {
                RDStudentInfoMode*studentinfoModel = [RDStudentInfoMode yy_modelWithJSON:dict];
                [arr addObject:studentinfoModel];
                
            }
            if (block)
            {
                block(YES, arr ,nil, nil);
            }
        
            
        }
        
    }];
    
}
+ (void)uploadImageWithBlock:(void(^)(BOOL result, NSString *failedMessage,NSError *error))block withParams:(NSMutableDictionary *)dict imageData:(NSData *)imageData imageName:(NSString *)imageName{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"text/plain",         nil];
    NSURLSessionDataTask *task =[manager POST:@"http://192.168.6.180:8088/ElangsInterface/stu/saveStudent" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpeg",imageName] mimeType:@"image/jpeg"];
        
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
   
        if([[responseObject objectForKey:@"code"] intValue]==0000)
        {
            block(YES, nil, nil);
        }
        else
        {
            block(NO, @"上传失败", nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(NO, @"网络不在家，出门兼职了", error);

    }];
    
    [task resume];
}

@end
