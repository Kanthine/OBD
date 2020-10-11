//
//  RequestURL.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/4.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#ifndef RequestURL_h
#define RequestURL_h

//  http://api.iex87.com/sure_api/shop 接口文档

#define TimeOutInterval 19.0f  //网络请求时间

#define DOMAINBASE @"http://api.iex87.com"
#define PublicInterface @"/api/sureapi/sure_common"
#define PrivateInterface @"/api/sureapi/sure_security"


#pragma mark - Public Port

#define GetVerificationCode @"get_code"//获取验证码
#define IsPhoneExit @"check_phone"//手机号是否存在
#define RegisterUser @"register"//注册
#define LoginUser @"login"//登录
#define ThirdLogin @"third_login"//第三方登录
#define ResetPassword @"reset_new_passwd"//重置密码









#pragma mark - Private Port

#define UpdateUserInfo @"update_user_info"//修改个人信息


#endif /* RequestURL_h */
