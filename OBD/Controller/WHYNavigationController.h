//
//  MyNavigationController.h
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 why. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHYNavigationBar.h"

@interface WHYNavigationController : UINavigationController

@property (nonatomic, assign) BOOL fullScreenPopGesture;
/**
 *  设置返回手势的范围，数值是距离页面左边的距离，默认是全屏。
 */
@property (nonatomic, assign) CGFloat maxAllowedInitialDistance;

@end

@interface UIViewController (WHYNavigationBar)

@property (nonatomic, strong) WHYNavigationBar *navigationBar;
@property (nonatomic, assign) BOOL navigationBarHidden;
//@property (nonatomic, copy) NSString *title;
/**
 *  导航栏的颜色
 */
@property (nonatomic,strong)UIColor * navBarGroundColor;
/**
 *  导航栏的标题颜色
 */
@property (nonatomic,strong)UIColor * navTitleColor;
@end