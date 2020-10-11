//
//  UIControl+SafeClick.h
//  NewXinLing
//
//  Created by Dinotech on 15/12/11.
//  Copyright © 2015年 why. All rights reserved.
//

#import <UIKit/UIKit.h>
static const char * UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char * UIControl_acceptIgnore = "UIControl_ignore";
@interface UIControl (SafeClick)
/**
 *  设置按钮重复点击的时间间隔
 */
@property (nonatomic,assign)NSTimeInterval ry_acceptClickEventInteral;

@property (assign,nonatomic)BOOL ry_ignoreEvent;

@end
