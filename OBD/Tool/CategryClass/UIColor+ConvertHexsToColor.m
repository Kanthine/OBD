//
//  NSString+ConvertHexsToColor.m
//  NewXinLing
//
//  Created by Dinotech on 15/12/8.
//  Copyright © 2015年 why. All rights reserved.
//


#import "UIColor+ConvertHexsToColor.h"
@implementation UIColor (ConvertHexsToColor)

+ (UIColor *)colorConvertWithHexString:(NSString *)color{
   
    return [self colorConvertWithHexString:color withAlpha:1.0f];
}

+ (UIColor *)colorConvertWithHexString:(NSString *)color withAlpha:(float)alpha{
    
    
    //首先删除字符串中德空格
    NSString * cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (cString.length<6) {
        return [UIColor clearColor];
    }
    //strip 0X if it appears
    //如果截取0x开头的，那么截取字符串，字符串索引从2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头，那么截取字符串，从索引1开始截取
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length!=6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location=0;
    range.length = 2;
    // R
    NSString * rString = [cString substringWithRange:range];
    range.location=2;
    NSString * gString = [cString substringWithRange:range];
    range.location=4;
    NSString * bString = [cString substringWithRange:range];
    unsigned int r,g,b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    
    
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0];
}
@end
