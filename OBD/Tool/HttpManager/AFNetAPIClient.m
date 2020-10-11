//
//  AFNetAPIClient.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/4.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "AFNetAPIClient.h"

@interface AFNetAPIClient()

@end



@implementation AFNetAPIClient


+ (AFNetAPIClient *)sharedClient
{
    static AFNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
      {
          NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
          //                      [config setHTTPAdditionalHeaders:@{@"User-Agent" : @"JHDJ iOS 1.0"}];
          
          NSURLCache* cache = [[NSURLCache alloc]initWithMemoryCapacity:10*1024*1024 diskCapacity:50*1024*1024 diskPath:nil];
          [config setURLCache:cache];
          
          
          //初始化 AFHTTPSessionManager
          NSURL * baseURL = [NSURL URLWithString:DOMAINBASE];
          _sharedClient = [[self alloc]initWithBaseURL:baseURL sessionConfiguration:config];
          
          
          _sharedClient.operationQueue.maxConcurrentOperationCount = 3;// 设置允许同时最大并发数量，过大容易出问题
          
          // 设置请求序列化器
          //                      _sharedClient.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;// 默认缓存策略
          [_sharedClient.requestSerializer willChangeValueForKey:@"timeoutInterval"];
          _sharedClient.requestSerializer.timeoutInterval = TimeOutInterval;
          [_sharedClient.requestSerializer didChangeValueForKey:@"timeoutInterval"];
          
          
          
          // 设置响应序列化器，解析Json对象
          AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
          responseSerializer.removesKeysWithNullValues = YES; // 清除返回数据的 NSNull
          //          responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/html", @"text/plain",nil]; // 设置接受数据的格式
          responseSerializer.readingOptions = NSJSONReadingAllowFragments;
          responseSerializer.acceptableContentTypes = [NSSet setWithObjects:  @"application/x-javascript", @"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil]; // 设置接受数据的格式
          _sharedClient.responseSerializer = responseSerializer;
          
          // 设置安全策略
          _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];;
          

      });
    
    return _sharedClient;
}

/*
 * post 请求
 * url 请求地址
 * parameters 请求参数
 *
 * SuccessBlock 请求结果 在分线程（最后记得回归主线程）
 * failBlock 若请求失败则返回错误，否则返回nil  在主线程
 */
-(NSURLSessionDataTask *)requestForPostUrl:(NSString*)url parameters:(NSDictionary *)parameters NetworkActivity:(BOOL)isShow SuccessBlock:(void (^)(id responseObject))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    if (isShow)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    else
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    
    /*
     * 有网络的情况下，使用网络加载数据
     */
    NSURLSessionDataTask* task = [self POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
      {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
      {
          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
          
          if (!responseObject || (![responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSArray class]])) // 若解析数据格式异常，返回错误
          {
              NSError *error = [NSError errorWithDomain:@"数据不正确" code:100 userInfo:nil];
              failBlock(error);
          }
          else if([[responseObject objectForKey:@"error_flag"] intValue] == 0)// 若解析数据正常，判断API返回的code，
          {
              successBlock(responseObject);
          }
          else
          {
              NSError *error = [NSError errorWithDomain:[responseObject objectForKey:@"result_msg"] code:[[responseObject objectForKey:@"error_flag"] integerValue] userInfo:nil];
              failBlock(error);
          }
          
      }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
      {
          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
          
          
          if (error.code == -1005 && [error.domain isEqualToString:@"NSURLErrorDomain"])
          {
              failBlock([NSError errorWithDomain:@"请检查您的网络是否正常" code:error.code userInfo:nil]);

          }
          else
          {
              failBlock(error);
          }
          
          NSLog(@"task.response ==== %@ error ========= %@",task.response,error);
          
      }];

    return task;    
}



@end
