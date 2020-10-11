//
//  UIButton+ShakeAnimation.h
//  NewXinLing
//
//  Created by Dinotech on 15/12/25.
//  Copyright © 2015年 why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ShakeAnimation)
/**
 *  增加按钮执行效果，主要用于用户登陆密码错误时的输入效果
 *
 *  @param timeinterval 执行时间
 *  @param count        重复次数 测试8 次附近比较好看
 *  @param percent      界面偏移量 10-90  default 0.3
 */
- (void)shakeAnimationWithPathDuration:(NSTimeInterval )timeinterval excutingTimes:(NSInteger)count delaPercent:(float)percent;
/**
 *  按钮根据关键帧执行操作
 *
 *  @param time    动画时间
 *  @param count   执行次数
 *  @param percent 每次偏移位置百分比
 */
- (void)shakeAnimationWithKeyValueDuration:(NSTimeInterval )time excutingTimes:(NSInteger)count delapercent:(float)percent;
/**
 *  增加block回调，在动画结束之后回调给UI界面
 *
 *  @param time     动画执行时间
 *  @param count    重复次数
 *  @param percent  视图偏移量 范围0.2 ~0.5 之间
 *  @param complete 完成回调处理
 */
- (void)shakeAnimationWithKeyValueDuration:(NSTimeInterval)time excutingTimes:(NSInteger)count delapercent:(float)percent withComplete:(void (^)(BOOL finish))complete;
/**
 *  使用关键路径回调的动画
 *
 *  @param timeinterval 执行时间
 *  @param count        重复次数
 *  @param percent      视图ofset
 *  @param block        回调处理UI
 */
- (void)shakeAnimationWithPathDuration:(NSTimeInterval)timeinterval excutingTimes:(NSInteger)count delaPercent:(float)percent withComplete:(void (^)(BOOL isFinish))block;


@end
