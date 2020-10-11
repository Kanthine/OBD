//
//  NSString+ChangeStr.h
//  OBD
//
//  Created by Why on 16/1/21.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ChangeStr)
/**
 *  16进制转换成普通字符
 *
 *  @param hexString 16进制字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;
/**
 *  将普通字符串转换成16进制
 *
 *  @param string 普通字符
 *
 *  @return 16精致字符
 */
+ (NSString *)hexStringFromString:(NSString *)string;

@end
