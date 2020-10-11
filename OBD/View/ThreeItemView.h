//
//  ThreeItemView.h
//  OBD
//
//  Created by Why on 16/3/28.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ThreeItemViewDelegate <NSObject>

- (void)threeItemSelect:(NSInteger)index;

@end

@interface ThreeItemView : UIView
/**
 *  查看
 */
@property(nonatomic,strong)UIButton * checkButton;
/**
 *  开关
 */
@property(nonatomic,strong)UIButton * switchButton;
/**
 *  故障码
 */
@property(nonatomic,strong)UIButton * errcodeButton;
/**
 *  2
 */
/**
 *  开启蓝牙 链接obd
 */
@property(nonatomic,strong)UILabel * middleLable;
/**
 *  3
 */
@property(nonatomic,strong)UILabel * errorcodeLable;
/**
 *  改变中间按钮
 *
 *  @param status
 */
- (void)changeMiddleValue;
@property(nonatomic,assign)id<ThreeItemViewDelegate>delegate;
@end

