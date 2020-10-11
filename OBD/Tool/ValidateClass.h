//
//  ValidateClass.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/23.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateClass : NSObject

+ (BOOL)isMobileOrEmail:(NSString *)string;

/*
 * 验证手机号
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel;

/*
 * 验证邮箱
 */
+ (BOOL)checkEmail:(NSString *)email;


@end
