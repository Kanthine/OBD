//
//  LeftBackItem.h
//  SURE
//
//  Created by 苏沫离 on 16/11/25.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftBackItem : UIBarButtonItem

- (instancetype)initWithTarget:(UIViewController *)target Selector:(SEL)method;

- (void)setNormalImage:(UIImage *)normalImage;

- (void)setHighlightedImage:(UIImage *)highlightedImage;

@end
