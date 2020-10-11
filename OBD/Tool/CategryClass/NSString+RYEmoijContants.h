//
//  NSString+RYEmoijContants.h
//  NewXinLing
//
//  Created by Dinotech on 15/12/23.
//  Copyright © 2015年 why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RYEmoijContants)
/**
 *  过滤输入文本中的emoij表情符号
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)stringContainsEmoijWithCode:(NSString *)string;

/**
 *  替换字符串中的表情符号
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)replaceStringEmoijWithNewString:(NSString *)string;

@end
