//
//  RDApiClient.m
//  教师管理系统
//
//  Created by 高小杰 on 2017/2/27.
//  Copyright © 2017年 高小杰. All rights reserved.
//

#import "RDApiClient.h"
#import "YYCache.h"
//YYCache缓存文件存放的文件夹
NSString * const HttpCache = @"HttpRequestCache";
@implementation RDApiClient

+(void)getRequestWithUrl:(NSString *)url withParams:(NSDictionary *)params successBlock:(void (^)(NSDictionary *))succsssBlock failureBlock:(void (^)(NSError *))errorBlock
{
    
    NSLog(@"=============%@",url);
    [MHNetworkManager getRequstWithURL:[NSString stringWithFormat:@"%@%@",baseUrl, url] params:params successBlock:^(NSDictionary *returnData) {
        succsssBlock(returnData);
        NSLog(@"---------=========%@",url);
        
    } failureBlock:^(NSError *error) {
       
        errorBlock(error);
        NSLog(@"==========%@",error);

    } showHUD:NO];
}

+(void)postRequestWithUrl:(NSString *)url withParams:(NSDictionary *)params successBlock:(void (^)(NSDictionary *))succsssBlock failureBlock:(void (^)(NSError *))errorBlock
{
    [MHNetworkManager postReqeustWithURL:[NSString stringWithFormat:@"%@%@",baseUrl,url] params:params successBlock:^(NSDictionary *returnData) {
        succsssBlock(returnData);
    } failureBlock:^(NSError *error) {
        errorBlock(error);
    } showHUD:NO];
}

+(void)getRequestWithCacheUrl:(NSString *)url withParams:(NSDictionary *)params cacheData:(id)cacheData isCache:(BOOL)isCache successBlock:(void (^)(NSDictionary *))succsssBlock failureBlock:(void (^)(NSError *, NSDictionary *))errorBlock
{
    //设置YYCache属性
    YYCache *cache = [[YYCache alloc] initWithName:HttpCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    NSString *url1=[NSString stringWithFormat:@"%@%@",baseUrl, url];
    url1=[url1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *allUrl=[self urlDictToStringWithUrlStr:url1 WithDict:params];
    [MHNetworkManager getRequstWithURL:[NSString stringWithFormat:@"%@", url] params:params successBlock:^(NSDictionary *returnData) {
        succsssBlock(returnData);
        
        [self dealWithResponseObject: [NSJSONSerialization dataWithJSONObject:returnData options:NSJSONWritingPrettyPrinted error:nil] cacheUrl:allUrl cacheData:cacheData isCache:YES cache:cache cacheKey:allUrl];
    } failureBlock:^(NSError *error) {
        id cacheData = [cache objectForKey:allUrl];
        NSDictionary *returnData;
        if(cacheData!=nil)
        {
            //将数据统一处理
            returnData = [self returnDataWithRequestData:cacheData];
        }
        errorBlock(error, returnData);
    } showHUD:NO];
}

#pragma mark  统一处理请求到的数据
+(void)dealWithResponseObject:(NSData *)responseData cacheUrl:(NSString *)cacheUrl cacheData:(id)cacheData isCache:(BOOL)isCache cache:(YYCache*)cache cacheKey:(NSString *)cacheKey  //cacheData暂不理会
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    
    
    NSString * dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (isCache) {
        //需要缓存,就进行缓存
        [cache setObject:requestData forKey:cacheKey];
        
    }
    /*
     //如果不缓存 或 数据不相同,就把网络返回的数据显示
     if (!isCache || ![cacheData isEqual:requestData]) {
     
     [self returnDataWithRequestData:requestData];
     }
     */
    
}

#pragma mark - 根据返回的数据进行统一的格式处理-requestData 网络或者是缓存的数据-
+ (NSDictionary *)returnDataWithRequestData:(NSData *)requestData
{
    id myResult = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    
    
    //判断是否为字典
    if ([myResult isKindOfClass:[NSDictionary  class]]) {
        NSDictionary *  response = (NSDictionary *)myResult;
        return response;
        //        //        //根据返回的接口内容来变
        //        id success = [response objectForKey:@"success"];
        //        NSString* message = [response objectForKey:@"message"];
        //        //success存在,并且为0时
        //        if(success && ![success boolValue])//处理掉0的情况,直接进报错处理
        //        {
        //            if([message isKindOfClass:[NSString class]] && message.length>0)
        //            {
        //                //message不为空
        //            } else
        //            {
        //                message = @"";
        //            }
        //
        //            return nil;
        //        }
        //
        //        NSLog(@"返回Json\n%@\n",response);
        //        //把data层剥掉
        //        NSDictionary *dict=[response objectForKey:@"data"];
        //
        //        [self showSuccess:response];
    }
    return nil;
}

#pragma mark -- 处理json格式的字符串中的换行符、回车符
+ (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

/**
 *  拼接请求的网络地址
 *
 *  @param urlStr     基础网址
 *  @param parameters 拼接参数
 *
 *  @return 拼接完成的网址
 */
+(NSString *)urlDictToStringWithUrlStr:(NSString *)urlString WithDict:(NSDictionary *)parameters
{
    if (!parameters) {
        return urlString;
    }
    
    
    NSMutableArray *parts = [NSMutableArray array];
    //enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block 这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //字符串处理
        key=[NSString stringWithFormat:@"%@",key];
        obj=[NSString stringWithFormat:@"%@",obj];
        
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parts addObject:part];
        
    }];
    
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    
    queryString = queryString.length!=0 ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",urlString,queryString];
    
    return pathStr;
    
}

@end
