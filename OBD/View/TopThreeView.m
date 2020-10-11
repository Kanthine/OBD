//
//  TopThreeView.m
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "TopThreeView.h"
#define WIDTH 66
#define HEIGHT 61
#define SPACE 10
#define TOPSPACE 16
@implementation TopThreeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
   [self addSubview:[self getView:self.redView colorsArray:[NSArray arrayWithObjects:(id)[UIColor colorConvertWithHexString:@"#ef2029"].CGColor,(id)[UIColor colorConvertWithHexString:@"#b71156"].CGColor, nil] frame:CGRectMake(SPACE, TOPSPACE, WIDTH, HEIGHT)]];
    [self addSubview:[self getView:self.yellowView colorsArray:[NSArray arrayWithObjects:(id)[UIColor colorConvertWithHexString:@"#f8bf0c"].CGColor,(id)[UIColor colorConvertWithHexString:@"#d1c501"].CGColor, nil] frame:CGRectMake(WIDTH+SPACE*2, TOPSPACE, WIDTH, HEIGHT)]];
    [self addSubview:[self getView:self.greenView colorsArray:[NSArray arrayWithObjects:(id)[UIColor colorConvertWithHexString:@"#009a82"].CGColor,(id)[UIColor colorConvertWithHexString:@"#045d7b"].CGColor, nil] frame:CGRectMake(WIDTH*2+SPACE*3, TOPSPACE, WIDTH, HEIGHT)]];
}
- (UIView*)getView:(UIView*)orginalView colorsArray:(NSArray*)colorArray frame:(CGRect)frame{
    if (!orginalView) {
        orginalView = [[UIView alloc]initWithFrame:frame];
        CAGradientLayer * gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        gradient.colors = colorArray;
        [orginalView.layer insertSublayer:gradient atIndex:0];
    }
    return orginalView;
}
@end
