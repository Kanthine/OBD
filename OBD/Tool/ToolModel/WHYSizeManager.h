//
//  WHYSizeManager.h
//  NewXinLing
//
//  Created by Why on 16/1/6.
//  Copyright © 2016年 why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHYSizeManager : NSObject
/**
 *  获得换算后的高度
 *
 *  @param originalHeight 原始的高度
 *
 *  @return 新的高度
 */
+ (float)getRelativelyHeight:(float)originalHeight;
/**
 *  获得换算后的宽度
 *
 *  @param originalWeight 原始的宽度
 *
 *  @return 新的宽度
 */
+ (float)getRelativelyWeight:(float)originalWeight;
/**
 *  传入对比高度
 *
 *  @param originalHeight 物体原高度
 *  @param comparedHeight 父视图高度
 *
 *  @return 换算的高度
 */
+ (float)getRelativelyHeight:(float)originalHeight comparedHeight:(float)comparedHeight;
@end
