//
//  LineView.m
//  OBD
//
//  Created by Why on 16/3/31.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "LineView.h"

@implementation LineView
{
    float _proportion;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame totalWidth:(float)width numberRange:(float)range color:(UIColor*)setColor{
    if (self == [super initWithFrame:frame]) {
        self.color = setColor;
        _proportion = width/range;
        self.layer.cornerRadius = 3.0;
        self.clipsToBounds = YES;
        
        [self.layer addSublayer:self.gradientLayer];
//
//        UIBezierPath *progressline = [UIBezierPath bezierPath];
//        
//        [progressline moveToPoint:CGPointMake(0, 0)];
//        [progressline addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
//        
//        [progressline setLineWidth:1.0];
//        [progressline setLineCapStyle:kCGLineCapSquare];
//        [self addAnimationIfNeededWithProgressLine:progressline];
    }
    return self;
}
- (CAGradientLayer*)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0.0, 0.0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        _gradientLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        NSArray * colors = @[(__bridge id)self.color.CGColor,(__bridge id)self.color.CGColor,(__bridge id)self.color.CGColor];
        _gradientLayer.colors = colors;
    }
    return _gradientLayer;
}


- (void)setCurrentValue:(float)currentValue{
    if (currentValue<0) {
        currentValue = 0;
    }
    float width = currentValue*_proportion;
    self.gradientLayer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
    //NSLog(@"%@",NSStringFromCGRect(self.gradientLayer.frame));
   
//   // NSLog(@"+= %@",NSStringFromCGRect(self.gradientLayer.frame));s
//    [self layoutIfNeeded];
}
@end
