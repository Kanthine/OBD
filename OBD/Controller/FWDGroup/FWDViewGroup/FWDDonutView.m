//
//  FWDDonutView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/8.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

#import "FWDDonutView.h"

#pragma mark - 水温环形进度

@interface TemperatureGradualView()

{
    CGFloat _lineWidth;
}

@property (nonatomic ,copy) NSString *valueString;

@property (nonatomic ,strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *valueLable;

@end

@implementation TemperatureGradualView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _lineWidth = 20;
        self.backgroundColor = [UIColor clearColor];
        // 默认轨迹track
        CAShapeLayer *defaultTrackLayer = [CAShapeLayer layer];
        defaultTrackLayer.frame = self.bounds;
        defaultTrackLayer.fillColor = [UIColor clearColor].CGColor;
        defaultTrackLayer.strokeColor = RGBA(151, 151, 151, 1).CGColor;
        defaultTrackLayer.opacity = 0.6f;// 背景透明度
        defaultTrackLayer.lineCap = kCALineCapRound;
        defaultTrackLayer.lineWidth = _lineWidth;
        defaultTrackLayer.path = self.bezierPath.CGPath;
        [self.layer addSublayer:defaultTrackLayer];
        
        
        [self addSubview:self.valueLable];
        [self.valueLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self setMyGradientLayer];
        
        [self setNeedsDisplay];
        
        [self setValueString:@"0.0"];
    }
    
    return self;
}


- (void)setMyGradientLayer
{
    //设置背景圆环渐变色
    
    CALayer *gradientLayer = [CALayer layer];
    
    CGFloat width = CGRectGetWidth(self.frame) / 2.0;
    CGFloat height = CGRectGetHeight(self.frame) / 2.0;
    CGFloat scale = _lineWidth / width;
    
    
    CGColorRef color1 = RGBA(38, 190, 217, .5).CGColor;
    CGColorRef color2 = RGBA(38, 190, 217, 1.0).CGColor;
    CGColorRef color3 = RGBA(230, 63, 63, 0.3).CGColor;
    CGColorRef color4 = RGBA(230, 63, 63, 0.6).CGColor;
    CGColorRef color5 = RGBA(230, 63, 63, 1.0).CGColor;
    
    //左下角
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, height, width,  height);
    gradientLayer1.colors = @[(__bridge id)color1, (__bridge id)color2];
    gradientLayer1.startPoint = CGPointMake(1, 1 - scale);
    gradientLayer1.endPoint = CGPointMake(scale, 0);
    [gradientLayer addSublayer:gradientLayer1];
    
    
    //左上角
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(0, 0, width,  height);
    gradientLayer2.colors = @[(__bridge id)color2, (__bridge id)color3];
    gradientLayer2.startPoint = CGPointMake(scale, 1);
    gradientLayer2.endPoint = CGPointMake(1, scale);
    [gradientLayer addSublayer:gradientLayer2];
    
    //右上角
    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];
    gradientLayer3.frame = CGRectMake(width, 0, width,  height);
    gradientLayer3.colors = @[(__bridge id)color3, (__bridge id)color4];
    gradientLayer3.startPoint = CGPointMake(0, scale);
    gradientLayer3.endPoint = CGPointMake(1 - scale, 1);
    [gradientLayer addSublayer:gradientLayer3];
    
    //右下角
    CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];
    gradientLayer4.frame = CGRectMake(width, height, width,  height);
    gradientLayer4.colors = @[(__bridge id)color4, (__bridge id)color5];
    gradientLayer4.startPoint = CGPointMake(1 - scale, 0);
    gradientLayer4.endPoint = CGPointMake(0, 1 - scale);
    [gradientLayer addSublayer:gradientLayer4];
    
    //progressLayer来截取渐变层, fill是clear stroke有颜色
    [gradientLayer setMask:self.progressLayer];
    
    [self.layer addSublayer:gradientLayer];
}

- (void)drawRect:(CGRect)rect
{
    [@"-40℃" drawAtPoint:CGPointMake(CGRectGetWidth(rect) / 10.0 , CGRectGetHeight(rect) * 9 / 10.0) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [@"215℃" drawAtPoint:CGPointMake(CGRectGetWidth(rect) * 7 / 10.0 , CGRectGetHeight(rect) * 9 / 10.0) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (void)setNewPercet:(CGFloat)newPercent OldPercet:(CGFloat)oldPercent
{
    if (oldPercent > 1)
    {
        oldPercent = 1;
    }
    if (newPercent > 1)
    {
        newPercent = 1;
    }
    
    
    [self.progressLayer removeAllAnimations];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:oldPercent];
    pathAnima.toValue = [NSNumber numberWithFloat:newPercent];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)setValueString:(NSString *)valueString
{
    if ([_valueString isEqualToString:valueString] == NO)
    {
        float oldWater = [_valueString floatValue];
        float oldPercent = (oldWater + 40) / (40.0 + 215.0);
        
        float newWater = [valueString floatValue];
        float newPercent = (newWater + 40) / (40.0 + 215.0);
        [self setNewPercet:newPercent OldPercet:oldPercent];
        
        self.valueLable.attributedText = [self setAttributeText:valueString];
        
        _valueString = valueString;
    }
}

- (NSMutableAttributedString *)setAttributeText:(NSString *)newString
{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:newString];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:NSMakeRange(0, string1.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string1.length)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"℃"];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string2.length)];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string2.length)];
    
    [string1 appendAttributedString:string2];

    return string1;
}

- (UILabel *)valueLable
{
    if (_valueLable == nil)
    {
        UILabel *lable = [[UILabel alloc]init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:32];
        lable.textColor = [UIColor whiteColor];
        
        _valueLable = lable;
    }
    return _valueLable;
}


- (UIBezierPath *)bezierPath
{
    if (_bezierPath == nil)
    {
        CGFloat center_X = CGRectGetWidth(self.frame) / 2.0;
        CGFloat center_Y = CGRectGetHeight(self.frame) / 2.0;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center_X, center_Y) radius:center_X - _lineWidth / 2.0 startAngle:degreesToRadians(135) endAngle:degreesToRadians(45) clockwise:YES];
        
        _bezierPath = path;
    }
    
    return _bezierPath;
}

- (CAShapeLayer *)progressLayer
{
    if (_progressLayer == nil)
    {
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.frame = self.bounds;
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        progressLayer.strokeColor = [UIColor blueColor].CGColor;
        progressLayer.lineCap = kCALineCapRound;
        progressLayer.lineWidth = _lineWidth;
        progressLayer.path = self.bezierPath.CGPath;
        progressLayer.strokeStart = 0;
        progressLayer.strokeEnd = 1;//当前进度
        
        _progressLayer = progressLayer;
    }
    
    return _progressLayer;
}

@end



#pragma mark - 空燃比环形进度

@interface AirFuelRatiView()

@property (nonatomic ,copy) NSString *valueString;
@property (nonatomic ,strong) UIImageView *bigImageView;
@property (nonatomic, strong) UILabel *valueLable;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation AirFuelRatiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bigImageView];
        
        
        [self addSubview:self.valueLable];
        [self.valueLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    /*
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(rect) / 2.0, CGRectGetWidth(rect) / 2.0) radius:(CGRectGetWidth(rect) / 2.0 - 15) startAngle:degreesToRadians(257) endAngle:degreesToRadians(203) clockwise:YES];
    CGFloat lengths[] = {2, 2};//表示先绘制10个点，再跳过10个点
    [bezierPath setLineDash:lengths count:2 phase:0];
    [bezierPath setLineWidth:3];
    [[UIColor redColor]  setStroke];
    [bezierPath stroke];
    
    
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(rect) / 2.0, CGRectGetWidth(rect) / 2.0) radius:(CGRectGetWidth(rect) / 2.0 - 25) startAngle:degreesToRadians(260) endAngle:degreesToRadians(200) clockwise:YES];
    [[UIColor redColor]  setStroke];
    [bezierPath1 stroke];
    
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = self.progressLayer.bounds;
    gradientLayer2.colors = @[(__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(1, 1);
    [gradientLayer addSublayer:gradientLayer2];
    
    //progressLayer来截取渐变层, fill是clear stroke有颜色
    [gradientLayer setMask:self.progressLayer];
    
    
    [self.layer addSublayer:gradientLayer];
    */
}

- (void)setValueString:(NSString *)valueString
{
    if ([_valueString isEqualToString:valueString] == NO)
    {
        self.valueLable.attributedText = [self setAttributeText:valueString];
        
        _valueString = valueString;
    }
}

- (void)setNewPercet:(CGFloat)newPercent OldPercet:(CGFloat)oldPercent
{
    if (oldPercent > 1)
    {
        oldPercent = 1;
    }
    if (newPercent > 1)
    {
        newPercent = 1;
    }
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:oldPercent];
    pathAnima.toValue = [NSNumber numberWithFloat:newPercent];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = YES;
    [self.progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}


- (NSMutableAttributedString *)setAttributeText:(NSString *)newString
{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:newString];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:NSMakeRange(0, string1.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string1.length)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"%"];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string2.length)];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string2.length)];
    
    [string1 appendAttributedString:string2];
    
    return string1;
}


- (UIImageView *)bigImageView
{
    if (_bigImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FWD_Air"]];
        imageView.frame = self.bounds;
        _bigImageView = imageView;
    }
    return _bigImageView;
}


- (UILabel *)valueLable
{
    if (_valueLable == nil)
    {
        UILabel *lable = [[UILabel alloc]init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:32];
        lable.textColor = [UIColor whiteColor];
        lable.attributedText = [self setAttributeText:@"43.0"];
        
        _valueLable = lable;
    }
    return _valueLable;
}

- (CAShapeLayer *)progressLayer
{
    if (_progressLayer == nil)
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetWidth(self.frame) / 2.0) radius:(CGRectGetWidth(self.frame) / 2.0 - 35) startAngle:degreesToRadians(262) endAngle:degreesToRadians(198) clockwise:YES];

        
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.frame = self.bounds;
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        progressLayer.lineCap = kCALineCapRound;
        progressLayer.lineWidth = 5;
        progressLayer.path = bezierPath.CGPath;
        progressLayer.strokeStart = 0;
        progressLayer.strokeEnd = 1;//当前进度
        

        
        _progressLayer = progressLayer;
    }
    
    return _progressLayer;
}

@end














@interface FWDDonutView()

{
    DonutScheduleType _donutType;
}

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) UILabel *valueLable;

@property (nonatomic) TemperatureGradualView *waterView;
@property (nonatomic) AirFuelRatiView *airView;

@end

@implementation FWDDonutView

- (instancetype)initWithFrame:(CGRect)frame Type:(DonutScheduleType)donutType
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _donutType = donutType;
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self addSubview:self.titleLable];
        
        if (donutType == DonutScheduleTypeWaterTemperature)
        {
            [self addSubview:self.waterView];
            [self.waterView layoutIfNeeded];
        }
        else if (donutType == DonutScheduleTypeAirFuelRatio)
        {
            [self addSubview:self.airView];
            [self.airView layoutIfNeeded];
        }
        
        [self addValueObserverEvent];
    }
    
    return self;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.frame), 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor whiteColor];
        
        
        if (_donutType == DonutScheduleTypeWaterTemperature)
        {
            lable.text = @"水温";
        }
        else if (_donutType == DonutScheduleTypeAirFuelRatio)
        {
            lable.text = @"空燃比";
        }
        
        
        _titleLable = lable;
    }
    return _titleLable;
}

- (TemperatureGradualView *)waterView
{
    if (_waterView == nil)
    {
        TemperatureGradualView *view = [[TemperatureGradualView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 200) / 2.0, CGRectGetMaxY(self.titleLable.frame) + 30, 200,200)];

        _waterView = view;
    }
    
    return _waterView;
}


- (AirFuelRatiView *)airView
{
    if (_airView == nil)
    {
        AirFuelRatiView *airView = [[AirFuelRatiView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 200) / 2.0, CGRectGetMaxY(self.titleLable.frame) + 30, 200,200)];
        
        _airView = airView;
    }
    
    return _airView;
}

- (void)addValueObserverEvent
{
    __weak __typeof__(self) weakSelf = self;
    
    if (_donutType == DonutScheduleTypeWaterTemperature)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
           
            [[CurrentOBDModel sharedCurrentOBDModel]obdWaterTempChangeWithBlock:^(NSString *waterTemp)
             {
//                 NSLog(@"水温 ====== %@",waterTemp);
                 if (waterTemp != nil)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         weakSelf.waterView.valueString = waterTemp;
                     });
                 }
             }];
        });

        
    }
    else if (_donutType == DonutScheduleTypeAirFuelRatio)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            
            //空燃比
            [[CurrentOBDModel sharedCurrentOBDModel]obdFuelRatioChangeWithBlock:^(NSString *fuelRatio)
             {
//                 NSLog(@"空燃比 ====== %@",fuelRatio);
                 if (fuelRatio != nil)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         weakSelf.airView.valueString = fuelRatio;
                     });
                 }

             }];            
            

        });

    }
}

@end
