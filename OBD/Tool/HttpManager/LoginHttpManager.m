//
//  LoginHttpManager.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/4.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "LoginHttpManager.h"
#import "AFNetAPIClient.h"
#import "ConsoleOutPutChinese.h"

@interface LoginHttpManager()
@property (nonatomic ,strong) AFNetAPIClient *netClient;
@property (nonatomic, strong) NSURLSessionTask *sessionTask;
@end


@implementation LoginHttpManager

- (void)dealloc
{
    NSLog(@"LoginHttpManager dealloc");
    
    [_netClient.operationQueue cancelAllOperations];
    
    [self cancelAllRequest];
}

- (void)cancelAllRequest
{
    if (self.sessionTask)
    {
        NSLog(@"取消数据请求 %@ %@\n",self,self.sessionTask);
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

- (AFNetAPIClient *)netClient
{
    if (_netClient == nil)
    {
        _netClient = [AFNetAPIClient sharedClient];
    }
    
    return _netClient;
}

/*
 * 判断手机号是否存在：
 */
- (void)isExitPhoneWithPhone:(NSString *)phoneStr SuccessBlock:(void (^)(BOOL isExit))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,IsPhoneExit];
    
    [self.netClient requestForPostUrl:urlString parameters:@{@"mobile_phone":phoneStr} NetworkActivity:YES SuccessBlock:^(id responseObject)
     {
         NSLog(@"判断手机号是否存在 ====== %@",responseObject);
         successBlock(YES);
     } FailBlock:^(NSError *error)
     {
         failBlock(error);
     }];
}

/*
 * 获取验证码
 * parameterDict 登录时需要参数：
 * mobile_phone ： 手机号
 */
- (void)getVerificationCodeWithParameterDict:(NSDictionary *)parameterDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,GetVerificationCode];
    
    [self.netClient requestForPostUrl:urlString parameters:parameterDict NetworkActivity:YES SuccessBlock:^(id responseObject)
     {
         NSLog(@"获取验证码 ====== %@",responseObject);
         NSString *codeString = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"salt"]];
         successBlock(codeString);
        
    } FailBlock:^(NSError *error)
    {
        failBlock(error);
    }];
}

/*
 * 注册
 * parameterDict 登录时需要参数：
 * mobile_phone ： 手机号
 * salt ：验证码
 * password 密码
 * froms : 苹果开发填写iOS 安卓开发填写Android
 */
- (void)regiserAccountWithParameter:(NSDictionary *)parametersDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,RegisterUser];
    
    [self.netClient requestForPostUrl:urlString parameters:parametersDict NetworkActivity:YES SuccessBlock:^(id responseObject)
    {
        NSLog(@"注册 ====== %@",responseObject);
        
        if ([[[responseObject objectForKey:@"data"] objectForKey:@"result"] intValue] == 1)
        {
            successBlock(@"成功");
        }
        else
        {
            failBlock([NSError errorWithDomain:@"注册失败" code:110 userInfo:nil]);
        }

    } FailBlock:^(NSError *error)
    {
        failBlock(error);
    }];
}

/*
 * 登录
 * parameterDict 登录时需要参数：
 * user_name ： 手机号
 * password 密码
 */
- (void)loginWithAccount:(NSString *)numberString Password:(NSString *)pwdString SuccessBlock:(void (^)(AccountInfo *acount))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,LoginUser];
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    [parametersDict setObject:numberString forKey:@"user_name"];
    [parametersDict setObject:pwdString forKey:@"password"];
    
    [self.netClient requestForPostUrl:urlString parameters:parametersDict NetworkActivity:YES SuccessBlock:^(id responseObject)
     {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSDictionary *reseltDict = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
             
             if (reseltDict && [reseltDict isKindOfClass:[NSDictionary class]])
             {
                 AccountInfo *user = [AccountInfo modelObjectWithDictionary:reseltDict];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     successBlock(user);
                 });
             }
             else
             {
                 NSLog(@"登录====== %@",[ConsoleOutPutChinese outPutJsonWithObj:responseObject]);
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     failBlock([NSError errorWithDomain:@"登录失败" code:101 userInfo:nil]);
                 });
             }
             
             
         });
     } FailBlock:^(NSError *error)
     {
         failBlock(error);
     }];

}

/*
 * 第三方登录
 * parameterDict 登录时需要参数：
 * aite_id ： 第三方id
 * login_type ： 1为qq 2为微信
 * nickname ： 用户名*
 * headimg ： 头像
 */
- (void)thirdPartyLoginWithParameterDict:(NSDictionary *)parametersDict  SuccessBlock:(void (^)(AccountInfo *acount))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,ThirdLogin];
    
    [self.netClient requestForPostUrl:urlString parameters:parametersDict NetworkActivity:YES SuccessBlock:^(id responseObject)
     {
//         NSLog(@"第三方登录 ====== %@",[ConsoleOutPutChinese outPutJsonWithObj:responseObject]);

         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSDictionary *reseltDict = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
             
             if (reseltDict && [reseltDict isKindOfClass:[NSDictionary class]])
             {
                 AccountInfo *user = [AccountInfo modelObjectWithDictionary:reseltDict];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     successBlock(user);
                 });
             }
             else
             {
                 NSLog(@"第三方登录 ====== %@",[ConsoleOutPutChinese outPutJsonWithObj:responseObject]);

                 dispatch_async(dispatch_get_main_queue(), ^{
                     failBlock([NSError errorWithDomain:@"登录失败" code:101 userInfo:nil]);
                 });
             }
             
         });
         
     } FailBlock:^(NSError *error)
     {
         failBlock(error);
     }];
}

/*
 * 重置密码：
 *
 * parameterDict 登录时需要参数：
 * user_name ： 手机号
 * password ：密码
 * salt ： 验证码
 */
- (void)resetPasswordWithParameters:(NSDictionary *)parametersDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PublicInterface,ResetPassword];
    
    [self.netClient requestForPostUrl:urlString parameters:parametersDict NetworkActivity:YES SuccessBlock:^(id responseObject)
     {
         NSLog(@"重置密码： ====== %@",responseObject);
         
         if ([[[responseObject objectForKey:@"data"] objectForKey:@"result"] intValue] == 1)
         {
             successBlock(@"成功");
         }
         else
         {
             failBlock([NSError errorWithDomain:@"修改失败" code:110 userInfo:nil]);
         }
         
     } FailBlock:^(NSError *error)
     {
         failBlock(error);
     }];
}


/* 修改个人信息
 *
 * parameterDict 登录时需要参数：
 * user_id ：用户id
 * nickname 用户昵称
 * headimg  用户头像地址
 * sex      用户性别 0，保密；1，男；2，女
 * birthday 用户生日 2016-02-30
 * minename 个性签名
 *
 */
- (void)updatePersonalInfoParameterDict:(NSDictionary *)parameterDict  SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",PrivateInterface,UpdateUserInfo];
    
    
    [self.netClient requestForPostUrl:urlString parameters:parameterDict NetworkActivity:YES SuccessBlock:^(id responseObject) {
        NSLog(@"修改个人信息 == %@",[ConsoleOutPutChinese outPutJsonWithObj:responseObject]);

        successBlock(@"");
    } FailBlock:^(NSError *error) {
        failBlock(error);
    }];

}



@end
