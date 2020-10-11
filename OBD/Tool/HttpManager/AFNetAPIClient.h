//
//  AFNetAPIClient.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/4.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "RequestURL.h"

@interface AFNetAPIClient : AFHTTPSessionManager

/*
 * 创建一个单例类
 */
+(AFNetAPIClient*)sharedClient;


/*
 * post 请求
 * url 请求地址
 * parameters 请求参数
 *
 * SuccessBlock 请求结果
 * failBlock 若请求失败则返回错误，否则返回nil  
 */
-(NSURLSessionDataTask *)requestForPostUrl:(NSString*)url parameters:(NSDictionary *)parameters NetworkActivity:(BOOL)isShow SuccessBlock:(void (^)(id responseObject))successBlock FailBlock:(void(^) (NSError *error))failBlock;

@end
