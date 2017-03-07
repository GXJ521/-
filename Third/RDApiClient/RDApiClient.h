//
//  RDApiClient.h
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDApiClient : NSObject
// 不带缓存
+ (void)getRequestWithUrl:(NSString *)url withParams:(NSDictionary *)params successBlock:(void(^)(NSDictionary *returnData))succsssBlock failureBlock:(void(^)(NSError *error))errorBlock;

+ (void)postRequestWithUrl:(NSString *)url withParams:(NSDictionary *)params successBlock:(void(^)(NSDictionary *returnData))succsssBlock failureBlock:(void(^)(NSError *error))errorBlock;
// 带缓存
+ (void)getRequestWithCacheUrl:(NSString *)url withParams:(NSDictionary *)params cacheData:(id)cacheData isCache:(BOOL)isCache successBlock:(void(^)(NSDictionary *returnData))succsssBlock failureBlock:(void(^)(NSError *error, NSDictionary *returnData))errorBlock;
@end
