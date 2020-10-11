//
//  BrokenLineView.m
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "BrokenLineView.h"

@implementation BrokenLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.pointArray = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i<self.pointArray.count; i++) {
        PointModel * pointModel = self.pointArray[i];
        if (i == 0) {
            CGContextMoveToPoint(context, pointModel.time, pointModel.value);
        }

    }
}
- (void)reloadViewWithModel:(PointModel*)currentPoint{
    [self.pointArray addObject:currentPoint];
}
@end

@implementation RoundPointView
- (instancetype)initWithFrame:(CGRect)frame isGreen:(BOOL)isgreen{
    if (self == [super initWithFrame:frame]) {
        self.isGreen = isgreen;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
    if (self.isGreen) {
        CGContextSetRGBStrokeColor(context, 160.0/255.0, 183.0/255.0, 81.0/255.0, 1);
    }else{
       CGContextSetRGBStrokeColor(context, 33.0/255.0, 157.0/255.0, 208.0/255.0, 1);
    }
   
}


@end
