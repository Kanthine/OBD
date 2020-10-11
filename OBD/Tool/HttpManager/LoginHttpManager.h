//
//  LoginHttpManager.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/4.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

@interface LoginHttpManager : NSObject

/*
 * 判断手机号是否存在：
 */
- (void)isExitPhoneWithPhone:(NSString *)phoneStr SuccessBlock:(void (^)(BOOL isExit))successBlock FailBlock:(void(^) (NSError *error))failBlock;

/*
 * 获取验证码
 * parameterDict 登录时需要参数：
 * mobile_phone ： 手机号
 * user_id: 用户id 第三方登录/重置密码需要录入*
 */
- (void)getVerificationCodeWithParameterDict:(NSDictionary *)parameterDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock;

/*
 * 注册
 * parameterDict 登录时需要参数：
 * mobile_phone ： 手机号
 * salt ：验证码
 * password 密码
 * froms : 苹果开发填写iOS 安卓开发填写Android
 */
- (void)regiserAccountWithParameter:(NSDictionary *)parametersDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock;

/*
 * 登录
 * parameterDict 登录时需要参数：
 * user_name ： 手机号
 * password 密码
 */
- (void)loginWithAccount:(NSString *)numberString Password:(NSString *)pwdString SuccessBlock:(void (^)(AccountInfo *acount))successBlock FailBlock:(void(^) (NSError *error))failBlock;


/*
 * 第三方登录
 * parameterDict 登录时需要参数：
 * aite_id ： 第三方id
 * login_type ： 1为qq 2为微信
 * nickname ： 用户名*
 * headimg ： 头像
 */
- (void)thirdPartyLoginWithParameterDict:(NSDictionary *)parametersDict  SuccessBlock:(void (^)(AccountInfo *acount))successBlock FailBlock:(void(^) (NSError *error))failBlock;

/*
 * 重置密码：
 *
 * parameterDict 登录时需要参数：
 * user_name ： 手机号
 * password ：密码
 * salt ： 验证码
 */
- (void)resetPasswordWithParameters:(NSDictionary *)parametersDict SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock;


/* 修改个人信息
 *
 * parameterDict 登录时需要参数：
 * user_id ：用户id
 * nickname 用户昵称
 * headimg  用户头像地址
 * sex      用户性别 0，保密；1，男；2，女
 * birthday 用户生日 2016-02-30
 * minename 个性签名
 */
- (void)updatePersonalInfoParameterDict:(NSDictionary *)parameterDict  SuccessBlock:(void (^)(NSString *verString))successBlock FailBlock:(void(^) (NSError *error))failBlock;

@end
