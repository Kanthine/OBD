//
//  UIButton+ShakeAnimation.m
//  NewXinLing
//
//  Created by Dinotech on 15/12/25.
//  Copyright © 2015年 why. All rights reserved.
//

#import "UIButton+ShakeAnimation.h"

@implementation UIButton (ShakeAnimation)

// 采取关键路径做动画
- (void)shakeAnimationWithPathDuration:(NSTimeInterval)timeinterval excutingTimes:(NSInteger)count delaPercent:(float)percent{
    // 方法一：绘制路径
        CGRect frame = self.frame;
     CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        // 创建路径
        CGMutablePathRef shakePath = CGPathCreateMutable();
        // 起始点
        CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    	for (int index = 0; index < count; index++)
    	{
            // 添加晃动路径 幅度由大变小
    		CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - frame.size.width * percent*(1-(float)index/count),CGRectGetMidY(frame));
    		CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + frame.size.width * percent*(1-(float)index/count),CGRectGetMidY(frame));
    	}
        // 闭合
        CGPathCloseSubpath(shakePath);
        shakeAnimation.path = shakePath;
        shakeAnimation.duration = timeinterval;
        // 释放
        CFRelease(shakePath);
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}
- (void)shakeAnimationWithKeyValueDuration:(NSTimeInterval)time excutingTimes:(NSInteger)count delapercent:(float)percent{
    // 方法二：关键帧（点）
     CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint layerPosition = self.layer.position;
    
    // 起始点
    NSValue *value1=[NSValue valueWithCGPoint:self.layer.position];
    // 关键点数组
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:value1, nil];
    for (int i = 0; i<count; i++) {
        // 左右晃动的点
        NSValue *valueLeft = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x-self.frame.size.width*percent*(1-(float)i/count), layerPosition.y)];
        NSValue *valueRight = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x+self.frame.size.width*percent*(1-(float)i/count), layerPosition.y)];
        
        [values addObject:valueLeft];
        [values addObject:valueRight];
    }
    // 最后回归到起始点
    [values addObject:value1];
    
    shakeAnimation.values = values;
    shakeAnimation.duration = time;
    
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}

- (void)shakeAnimationWithPathDuration:(NSTimeInterval)timeinterval excutingTimes:(NSInteger)count delaPercent:(float)percent withComplete:(void (^)(BOOL))block{
    [self shakeAnimationWithPathDuration:timeinterval excutingTimes:count delaPercent:percent];
    block(YES);
    
}
- (void)shakeAnimationWithKeyValueDuration:(NSTimeInterval)time excutingTimes:(NSInteger)count delapercent:(float)percent withComplete:(void (^)(BOOL))complete{
    [self shakeAnimationWithKeyValueDuration:time excutingTimes:count delapercent:percent];
    complete(YES);
    
}
@end
