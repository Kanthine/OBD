//
//  WHYMBProgressView.h
//  AnimationText 16-2-22
//
//  Created by Why on 16/2/23.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef WHYMB_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define WHYMB_INSTANCETYPE instancetype
#else
#define WHYMB_INSTANCETYPE id
#endif
#endif

@interface WHYMBProgressView : UIView

+ (WHYMB_INSTANCETYPE)whyShowHUDAddedTo:(UIView*)view;

+ (void)whyHideHUDForView:(UIView*)view;
@end
