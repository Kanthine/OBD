//
//  ZFNavigationBar.h
//  TestNavigationController
//
//  Created by zhangfei on 15/11/27.
//  Copyright © 2015年 why. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHYNavigationBarDelegate;

@interface WHYNavigationBar : UIView

@property (nonatomic, weak) id<WHYNavigationBarDelegate> delegate;
@property (nonatomic, strong) UIView *barLine;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *backItem;

@end

@protocol WHYNavigationBarDelegate <NSObject>

- (void)didClickBackitem;

@end
