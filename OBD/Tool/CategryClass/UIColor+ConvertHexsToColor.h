//
//  NSString+ConvertHexsToColor.h
//  NewXinLing
//
//  Created by Dinotech on 15/12/8.
//  Copyright © 2015年 why. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor (ConvertHexsToColor)

/**
 *  将十六进制颜色转换成系统颜色
 *
 *  @param string 传入十六进制
 *
 *  @return 返回一个颜色值
 */
+ (UIColor *)colorConvertWithHexString:(NSString *)string;

/**
 *  附带透明度的颜色转换
 *
 *  @param string 十六进制颜色
 *  @param alpha  传入一个float 类型
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorConvertWithHexString:(NSString *)string withAlpha:(float)alpha;


@end
