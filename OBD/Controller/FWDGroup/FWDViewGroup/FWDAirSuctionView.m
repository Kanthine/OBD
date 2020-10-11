//
//  FWDAirSuctionView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/8.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "FWDAirSuctionView.h"


typedef NS_ENUM(NSUInteger,AirSuctionType)
{
    AirSuctionTypePressure = 0,
    AirSuctionTypeFlow,
    AirSuctionTypeTemperature,
};


@interface FWDAirSuctionItemProgressView()
// 0 ~ 1
@property (nonatomic) float progress;

@property (nonatomic ,strong) CAShapeLayer *shapeLayer;
@property (nonatomic ,strong) CAGradientLayer *gradientLayer;

@end

@implementation FWDAirSuctionItemProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) / 2.0)];
//    [bezierPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * _progress, CGRectGetHeight(self.frame) / 2.0)];
    
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2.0)];
    
    CGFloat lengths[] = {1, 1};//表示先绘制10个点，再跳过10个点
    [bezierPath setLineDash:lengths count:2 phase:0];
    [bezierPath setLineWidth:CGRectGetHeight(self.frame)];
    [RGBA(151, 151, 151, 1) setStroke];
    [bezierPath stroke];
}

- (void)setProgress:(float)progress
{
    if (progress >= 1.0)
    {
        _progress = 1.0;
    }
    _progress = progress;
    
    self.shapeLayer.strokeEnd = progress;
    
    
//    [self setNeedsDisplay];
}

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        UIBezierPath *bezierPath =  [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) / 2.0)];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2.0)];

        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.path = bezierPath.CGPath;
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        progressLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        progressLayer.lineWidth = CGRectGetHeight(self.frame);
        progressLayer.lineDashPattern = [NSArray arrayWithObjects:@1, @1, nil];
        progressLayer.strokeStart = 0;
        progressLayer.strokeEnd = 0.1;//当前进度
        
        _shapeLayer = progressLayer;
    }
    
    return _shapeLayer;
}

- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil)
    {
        CGColorRef color1 = RGBA(61, 235, 5, 1).CGColor;
        CGColorRef color2 = RGBA(255, 0, 0, 1).CGColor;
        
        CAGradientLayer *gradientlayer = [CAGradientLayer layer];
        gradientlayer.frame = self.bounds;
        gradientlayer.colors = @[(__bridge id)color1, (__bridge id)color2];
        gradientlayer.mask = self.shapeLayer;
        gradientlayer.startPoint = CGPointMake(0, 0.5);
        gradientlayer.endPoint = CGPointMake(1, 0.5);
        
        _gradientLayer = gradientlayer;
    }
    return _gradientLayer;
}


@end

















@interface FWDAirSuctionItemView()

{
    AirSuctionType _airType;
}

@property (nonatomic ,copy) NSString *currentValueString;

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) UILabel *valueLable;

@property (nonatomic ,strong) FWDAirSuctionItemProgressView *progressView;

@end


@implementation FWDAirSuctionItemView

- (instancetype)initWithFrame:(CGRect)frame Type:(AirSuctionType)airType
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _airType = airType;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.logoImageView];
        [self addSubview:self.titleLable];
        [self addSubview:self.progressView];
        [self addSubview:self.valueLable];

        [self setCurrentValueString:@"0.0"];
    }
    
    return self;
}


- (FWDAirSuctionItemProgressView *)progressView
{
    if (_progressView == nil)
    {
        FWDAirSuctionItemProgressView *progressView = [[FWDAirSuctionItemProgressView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 120, 50, 100, 20)];
        progressView.center = CGPointMake(progressView.center.x, self.titleLable.center.y);
        progressView.progress = 0.86;

        _progressView = progressView;
    }
    
    return _progressView;
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.frame) - 70) / 2.0 , 100, 40)];
        imageView.tintColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if (_airType == AirSuctionTypePressure)
        {
            imageView.image = [UIImage imageNamed:@"FWD_JinQiYaLi"];
        }
        else if (_airType == AirSuctionTypeFlow)
        {
            imageView.image = [UIImage imageNamed:@"FWD_JinQiLiuLiang"];
        }
        else if (_airType == AirSuctionTypeTemperature)
        {
            imageView.image = [UIImage imageNamed:@"FWD_JinQiWenDu"];
        }
        
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame) + 10, CGRectGetWidth(self.logoImageView.frame), 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor whiteColor];
        
        
        if (_airType == AirSuctionTypePressure)
        {
            lable.text = @"进气压力";
        }
        else if (_airType == AirSuctionTypeFlow)
        {
            lable.text = @"进气流量";
        }
        else if (_airType == AirSuctionTypeTemperature)
        {
            lable.text = @"进气温度";
        }
                
        _titleLable = lable;
    }
    return _titleLable;
}

- (UILabel *)valueLable
{
    if (_valueLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.progressView.frame), CGRectGetMinY(self.progressView.frame) - 44, CGRectGetWidth(self.progressView.frame), 34)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:32];
        lable.textColor = [UIColor whiteColor];
        
        _valueLable = lable;
    }
    return _valueLable;
}

- (void)setCurrentValueString:(NSString *)currentValueString
{
    if ([_currentValueString isEqualToString:currentValueString] == NO)
    {
        _currentValueString = currentValueString;

        
        //进气压力 0~255kPa
        //进气流量 0~655.35  0~150
        //进气温度 -40~+215
        
        CGFloat ratio = 0.0;//所占比例
        if (_airType == AirSuctionTypePressure)
        {
            ratio = currentValueString.floatValue / 255.0;
        }
        else if (_airType == AirSuctionTypeFlow)
        {
            ratio = currentValueString.floatValue / 150.0;
        }
        else if (_airType == AirSuctionTypeTemperature)
        {
            ratio = currentValueString.floatValue / 215.0;
        }
        
        self.valueLable.attributedText = [self setAttributeText:currentValueString];
        self.progressView.progress = ratio;
    }
}


- (NSMutableAttributedString *)setAttributeText:(NSString *)newString
{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:newString];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, string1.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string1.length)];
    
    
    
    NSString *symbolStr = @"";
    if (_airType == AirSuctionTypePressure)
    {
        symbolStr = @"pa";
    }
    else if (_airType == AirSuctionTypeFlow)
    {
        symbolStr = @"g/s";
    }
    else if (_airType == AirSuctionTypeTemperature)
    {
        symbolStr = @"℃";
    }

    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:symbolStr];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, string2.length)];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string2.length)];
    
    [string1 appendAttributedString:string2];
    
    return string1;
}



@end







@interface FWDAirSuctionView()

@property (nonatomic ,strong) FWDAirSuctionItemView *pressureView;
@property (nonatomic ,strong) FWDAirSuctionItemView *flowView;
@property (nonatomic ,strong) FWDAirSuctionItemView *temperatureView;

@end

@implementation FWDAirSuctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self addSubview:self.pressureView];
        [self addSubview:self.flowView];
        [self addSubview:self.temperatureView];
        [self addValueObserverEvent];
    }
    
    return self;
}

- (FWDAirSuctionItemView *)pressureView
{
    if (_pressureView == nil)
    {
        FWDAirSuctionItemView *itemView = [[FWDAirSuctionItemView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 3.0) Type:AirSuctionTypePressure];
        
        _pressureView = itemView;
    }
    
    return _pressureView;
}

- (FWDAirSuctionItemView *)flowView
{
    if (_flowView == nil)
    {
        FWDAirSuctionItemView *itemView = [[FWDAirSuctionItemView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pressureView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 3.0) Type:AirSuctionTypeFlow];
        
        
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
        topLineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.3];
        [itemView addSubview:topLineView];
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(itemView.frame) - 1, CGRectGetWidth(self.frame), 1)];
        bottomLineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.3];
        [itemView addSubview:bottomLineView];

        
        _flowView = itemView;
    }
    
    return _flowView;
}


- (FWDAirSuctionItemView *)temperatureView
{
    if (_temperatureView == nil)
    {
        FWDAirSuctionItemView *itemView = [[FWDAirSuctionItemView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.flowView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 3.0) Type:AirSuctionTypeTemperature];
        
        _temperatureView = itemView;
    }
    
    return _temperatureView;
}

- (void)addValueObserverEvent
{
    __weak __typeof__(self) weakSelf = self;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{

        //进气压力
        [[CurrentOBDModel sharedCurrentOBDModel]obdIntakePressureChangeWithBlock:^(NSString *intakePressure)
         {
//             NSLog(@"进气压力 ======== %@",intakePressure);
             if (intakePressure != nil)
             {
                dispatch_async(dispatch_get_main_queue(), ^{
                     weakSelf.pressureView.currentValueString = intakePressure;
                 });
             }

             
         }];
        
        });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{

        //进气流量
        [[CurrentOBDModel sharedCurrentOBDModel]obdIntakeFlueChangeWithBlock:^(NSString *intakeFlue)
         {
//             NSLog(@"进气流量 ======== %@",intakeFlue);
             if (intakeFlue != nil)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     weakSelf.flowView.currentValueString = intakeFlue;
                 });
             }

             
         }];
        
        });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{

        //进气温度
        [[CurrentOBDModel sharedCurrentOBDModel]obdIntakeTempChangeWithBlock:^(NSString *intakeTemp)
         {
//             NSLog(@"进气温度 ======== %@",intakeTemp);
             if (intakeTemp != nil)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     weakSelf.temperatureView.currentValueString = intakeTemp;
                 });
             }
             
         }];

        
    });

}

@end
