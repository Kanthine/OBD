//
//  NSString+RYEmoijContants.m
//  NewXinLing
//
//  Created by Dinotech on 15/12/23.
//  Copyright © 2015年 why. All rights reserved.
//

#import "NSString+RYEmoijContants.h"

@implementation NSString (RYEmoijContants)

- (BOOL)stringContainsEmoijWithCode:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
/**
 *  替换系统中的表情符号
 *
 *  @param string 需要替换的字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)replaceStringEmoijWithNewString:(NSString *)string{
    
    __weak NSString * returnValue = @"-";
 __weak   NSMutableString * mutiString = [NSMutableString string];
   
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         // 情😄你🐶
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     [mutiString appendString:returnValue];
                     
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 [mutiString appendString:returnValue];
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 [mutiString appendString:returnValue];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 [mutiString appendString:returnValue];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 [mutiString appendString:returnValue];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 [mutiString appendString:returnValue];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 [mutiString appendString:returnValue];
             }else{
                 [mutiString appendString:substring];
                  
                 
             }
             
         }
     }];

    
    return mutiString;
    
}
@end