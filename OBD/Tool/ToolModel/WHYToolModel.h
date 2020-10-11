//
//  WHYToolModel.h
//  OBD
//
//  Created by Why on 16/1/21.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHYToolModel : NSObject
/**
 *  根据16进制返回10进制
 *
 *  @param commondCodeStr 16进制命令
 *
 *  @return 10进制数值
 */
+ (NSString*)getHexNumFrom:(NSString*)commondCodeStr;
/**
 *  根据命令符返回单位
 *
 *  @param commondCodeStr 命令符
 *
 *  @return 单位
 */
+ (NSString*)getUnitFrom:(NSString*)commondCodeStr;

+ (UIColor*)getBigTitleColor;
@end
