//
//  LocalConfigurationData.h
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>

//品牌类型
typedef NS_ENUM(NSUInteger,UserProductType)
{
    UserProductTypeNone = 0,
    UserProductTypeDefault,
    UserProductTypeFWD
};

//控制盒自动模式下的数据
typedef NS_ENUM(NSUInteger,BoxControlAutoPattern)
{
    BoxControlAutoPatternComfortable = 0,//舒适模式
    BoxControlAutoPatternGeneral,//普通模式
    BoxControlAutoPatternSport//运动模式
};


@interface LocalConfigurationData : NSObject

/* 退出登录后消除用户所有本地数据 */
+ (void)clearAllUserLocalData;

/* 设置用户选择的产品类型 */
+ (void)setUserBrandType:(UserProductType)productType;

/* 获取用户选择的产品类型 */
+ (UserProductType)getUserBrandType;


/* 设置控制盒的自动模式 */
+ (void)setBoxControlAutoPattern:(BoxControlAutoPattern)boxControlPattern;

/* 获取控制盒的自动模式类型 */
+ (BoxControlAutoPattern)getBoxControlPattern;

/* 设置控制盒的是否链接 */
+ (void)setBoxLinkStatus:(BOOL)isLinked;

/* 获取控制盒是否链接 */
+ (BOOL)getBoxControlIsLinked;

@end
