//
//  ControlBoxWaveView.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "ControlBoxWaveView.h"

@interface ControlBoxWaveView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *imageContentView;
@property (nonatomic ,strong) UIView *waveView;

@end

@implementation ControlBoxWaveView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        CGFloat space = 85;
        self.frame = CGRectMake(space, (ScreenHeight - (ScreenWidth - space * 2) ) / 2.0, ScreenWidth - space * 2, ScreenWidth - space * 2);
        self.clipsToBounds = YES;
        
        [self addSubview:self.imageContentView];
        [self addSubview:self.imageView];

    }
    
    return self;
}

- (UIView *)imageContentView
{
    if (_imageContentView == nil)
    {
        _imageContentView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.15, CGRectGetWidth(self.frame) * 0.15, CGRectGetWidth(self.frame) * 0.7,  CGRectGetWidth(self.frame) * 0.7)];
        _imageContentView.backgroundColor = [UIColor whiteColor];
        _imageContentView.layer.cornerRadius = CGRectGetWidth(_imageContentView.frame) / 2.0;
        _imageContentView.clipsToBounds = YES;
        
    }
    
    return _imageContentView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FWD_Wave"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(CGRectGetWidth(self.imageContentView.frame) * 0.15, CGRectGetWidth(self.imageContentView.frame) * 0.15, CGRectGetWidth(self.imageContentView.frame) * 0.7, CGRectGetWidth(self.imageContentView.frame) * 0.7);
        _imageView.center = self.imageContentView.center;
        
        
        _imageView.animationImages = @[[UIImage imageNamed:@"FWD_Wave1"],[UIImage imageNamed:@"FWD_Wave2"]];
        
        
        _imageView.animationDuration = 0.2;//设置动画时间
        _imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
    }
    
    return _imageView;
}

- (UIView *)waveView
{
    if (_waveView == nil)
    {
        UIView *waveView = [[UIView alloc] init];
        waveView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
        waveView.layer.backgroundColor = [UIColor clearColor].CGColor;
        
        
        
        //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
        //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
        CAShapeLayer *pulseLayer = [CAShapeLayer layer];
        pulseLayer.frame = waveView.layer.bounds;
        pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
//        pulseLayer.fillColor = RGBA(64, 64, 64, 1).CGColor;
        pulseLayer.fillColor = RGBA(255, 255, 255, 1).CGColor;
        pulseLayer.opacity = 0.0;
        
        //可以复制layer
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = waveView.bounds;
        replicatorLayer.instanceCount = 2;//创建副本的数量,包括源对象。
        replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
        [replicatorLayer addSublayer:pulseLayer];
        [waveView.layer addSublayer:replicatorLayer];
        
        CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnima.fromValue = @(0.5);
        opacityAnima.toValue = @(0.0);
        
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
        scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0.0)];
        scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
        
        CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
        groupAnima.animations = @[opacityAnima, scaleAnima];
        groupAnima.duration = 2.0;
        groupAnima.autoreverses = NO;
        groupAnima.repeatCount = HUGE;
        [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
        
        
        _waveView = waveView;
    }
    
    return _waveView;
}

- (void)startFWDAnimation
{
    [self.imageView startAnimating];
    [self.waveView removeFromSuperview];
    _waveView = nil;
    if (_waveView == nil)
    {
        [self insertSubview:self.waveView atIndex:0];
    }
}

- (void)stopFWDAnimation
{
    [self.imageView stopAnimating];
    [self.waveView removeFromSuperview];
    _waveView = nil;
}

- (void)matchSuccessAnimationBlock:(void (^)(UIImage *, CGSize))block
{
    [self.waveView.layer removeAllAnimations];
    
    [UIView animateWithDuration:.9f animations:^
    {
        self.waveView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished)
     {
         if (finished)
         {
             block(self.imageView.image,self.imageView.frame.size);
             self.imageView.hidden = YES;
             self.imageContentView.hidden = YES;
             [self.waveView removeFromSuperview];
             _waveView = nil;
         }
    }];
}

@end
