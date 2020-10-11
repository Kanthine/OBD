//
//  SwitchOnewView.h
//  OBD
//
//  Created by Why on 16/4/5.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchOnewViewDelegate <NSObject>
/**
 *  开关状态变化
 *
 *  @param statusNum 0开启1关闭2自动
 */
- (void)switchStatusChangeWith:(NSInteger)statusNum;

@end
@interface SwitchOnewView : UIView
@property(nonatomic,strong)UIView * moveColorView;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)CAGradientLayer * gradientLayer;
@property(nonatomic,assign)id<SwitchOnewViewDelegate>delegate;
- (float)getCenterY:(NSInteger)index;
@end

