//
//  BrokenLineView.h
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  折线统计图
 */
@interface BrokenLineView : UIView
/**
 *  存所有点的数组
 */
@property(nonatomic,strong)NSMutableArray * pointArray;
/**
 *  更新view
 *
 *  @param currentPoint 新的坐标点
 */
- (void)reloadViewWithModel:(PointModel*)currentPoint;
@end
/**
 *  绿圆点和蓝圆点
 */
@interface RoundPointView : UIView

@property(nonatomic,assign)BOOL isGreen;//是绿色的
- (instancetype)initWithFrame:(CGRect)frame isGreen:(BOOL)isgreen;

@end