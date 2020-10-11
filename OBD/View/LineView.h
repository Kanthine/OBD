//
//  LineView.h
//  OBD
//
//  Created by Why on 16/3/31.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView
- (instancetype)initWithFrame:(CGRect)frame totalWidth:(float)width numberRange:(float)range color:(UIColor*)setColor;
@property (nonatomic,strong) CAGradientLayer * gradientLayer;
@property (nonatomic,strong) UIColor * color;
@property (nonatomic,assign) float currentValue;
@end
