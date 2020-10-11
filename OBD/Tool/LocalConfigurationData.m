//
//  LocalConfigurationData.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define UserDefaults [NSUserDefaults standardUserDefaults]
#define ProductType @"ProductType"
#define BoxControlPattern @"boxControlPattern"
#define BoxLinkStatus @"BoxLinkStatus"


#import "LocalConfigurationData.h"


// 本地配置信息
@implementation LocalConfigurationData

/* 退出登录后消除用户所有本地数据 */
+ (void)clearAllUserLocalData
{
    [UserDefaults removeObjectForKey:BoxControlPattern];
    [UserDefaults removeObjectForKey:ProductType];
    [UserDefaults synchronize];
}

/* 设置用户选择的产品类型 */
+ (void)setUserBrandType:(UserProductType)productType
{
    [UserDefaults setObject:@(productType) forKey:ProductType];
    [UserDefaults synchronize];
}

/* 获取用户选择的产品类型 */
+ (UserProductType)getUserBrandType
{
    return [[UserDefaults objectForKey:ProductType] integerValue];
}

/* 设置控制盒的自动模式 */
+ (void)setBoxControlAutoPattern:(BoxControlAutoPattern)boxControlPattern
{
    [UserDefaults setObject:@(boxControlPattern) forKey:BoxControlPattern];
    [UserDefaults synchronize];
}

/* 获取控制盒的自动模式类型 */
+ (BoxControlAutoPattern)getBoxControlPattern
{
    return [[UserDefaults objectForKey:BoxControlPattern] integerValue];
}

/* 设置控制盒的是否链接 */
+ (void)setBoxLinkStatus:(BOOL)isLinked
{
    [UserDefaults setObject:@(isLinked) forKey:BoxLinkStatus];
    [UserDefaults synchronize];
}

/* 获取控制盒是否链接 */
+ (BOOL)getBoxControlIsLinked
{
    return [[UserDefaults objectForKey:BoxLinkStatus] boolValue];
}

@end
