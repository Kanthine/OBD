//
//  AuthorizationManager.h
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocalConfigurationData.h"

@interface AuthorizationManager : NSObject

//用户是否登录
+ (BOOL)isLoginState;

//用户选择的产品类型
+ (UserProductType)getUserBrandType;


@end
/*
 关于权限的设置：
 1、用户未登录：去登陆
 2、用户未选择产品类型：选择产品类型
 3、手机未开启蓝牙：开启蓝牙
 4、未扫描到产品：扫描产片
 */
