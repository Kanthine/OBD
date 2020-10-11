//
//  UIViewController+LeftPopClickListener.h
//  NewXinLing
//
//  Created by Dinotech on 15/12/18.
//  Copyright © 2015年 why. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SystemLeftItemClickResponceDelegate <NSObject>

@optional
- (BOOL)currentNavgationItemCallBackResponce;

@end


@interface UIViewController (LeftPopClickListener)<SystemLeftItemClickResponceDelegate>

@end
