//
//  UIViewController+LeftPopClickListener.m
//  NewXinLing
//
//  Created by Dinotech on 15/12/18.
//  Copyright © 2015年 why. All rights reserved.
//

#import "UIViewController+LeftPopClickListener.h"

@implementation UIViewController (LeftPopClickListener)

@end

@implementation UINavigationController (SendItemClickAction)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    if (self.viewControllers.count<navigationBar.items.count) {
        return YES;
    }
    BOOL shouldPOP  = YES;
    UIViewController * vc  = [self visibleViewController];
    
    if ([vc respondsToSelector:@selector(currentNavgationItemCallBackResponce)]) {
       shouldPOP =  [vc currentNavgationItemCallBackResponce];
    }
    if (shouldPOP) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        
    }else{
        for (UIView * navSUbview in navigationBar.subviews) {
            if (navSUbview.alpha<1.0f) {
                [UIView animateWithDuration:1.0 animations:^{
                    navSUbview.alpha=1.0f;
                    
                }];
            }
        }
    }
    return NO;
    
}

@end