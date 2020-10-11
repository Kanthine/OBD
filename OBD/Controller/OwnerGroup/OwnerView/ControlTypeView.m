//
//  ControlTypeView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define Space 5

#import "ControlTypeView.h"

@interface ControlTypeView()

{
    ControlType _type;
}

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) CALayer *redLayer;
@end

@implementation ControlTypeView

- (instancetype)initWithFrame:(CGRect)frame Type:(ControlType)type
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGBA(64, 64, 64, 1);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetHeight(frame) / 2.0;
        
        _type = type;
        
        [self.layer addSublayer:self.redLayer];
        [self addSubview:self.titleLable];
        [self addSubview:self.logoImageView];
        [self addSubview:self.button];
    }
    
    return self;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, (CGRectGetHeight(self.frame) - 20) / 2.0, 100, 20)];
        lable.textColor = RGBA(151, 151, 151, 1);
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = [UIFont systemFontOfSize:14];
        lable.backgroundColor = [UIColor clearColor];
        
        switch (_type)
        {
            case ControlTypeOn:
                lable.text = @"开";
                break;
            case ControlTypeOff:
                lable.text = @"关";
                break;
            case ControlTypeAuto:
                lable.text = @"自动";
                break;
            default:
                break;
        }
        
        _titleLable = lable;
    }
    
    return _titleLable;
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (_isSelected != isSelected)
    {
        if (isSelected)
        {
            self.titleLable.textColor = [UIColor whiteColor];
            self.redLayer.frame = CGRectMake(CGRectGetMinY(self.redLayer.frame), CGRectGetMinY(self.redLayer.frame), CGRectGetWidth(self.frame) - CGRectGetMinY(self.redLayer.frame) * 2, CGRectGetHeight(self.redLayer.frame));
        }
        else
        {
            self.titleLable.textColor = RGBA(151, 151, 151, 1);
            self.redLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetMinY(self.redLayer.frame) - CGRectGetHeight(self.redLayer.frame), CGRectGetMinY(self.redLayer.frame), CGRectGetHeight(self.redLayer.frame), CGRectGetHeight(self.redLayer.frame));

        }
        
        
        _isSelected = isSelected;
    }
    
}

- (CALayer *)redLayer
{
    if (_redLayer == nil)
    {
        CALayer *redLayer = [CALayer layer];
        redLayer.backgroundColor = RGBA(232, 106, 90, 1).CGColor;
        
        CGFloat height = CGRectGetHeight(self.frame) - Space * 2;
        
        redLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - height - Space, Space, height, height);
        redLayer.cornerRadius = CGRectGetWidth(redLayer.frame) / 2.0;
        redLayer.masksToBounds = YES;
        
        _redLayer = redLayer;
    }
    
    return _redLayer;
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
        CGRect rect = self.redLayer.frame;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake( CGRectGetMinX(rect) + (CGRectGetWidth(rect) - 30 ) / 2,CGRectGetMinY(rect) + (CGRectGetWidth(rect) - 30 ) / 2, 30, 30)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        switch (_type)
        {
            case ControlTypeOn:
                imageView.image = [UIImage imageNamed:@"owner_ControlTypeOn"];
                break;
            case ControlTypeOff:
                imageView.image = [UIImage imageNamed:@"owner_ControlTypeOff"];
                break;
            case ControlTypeAuto:
                imageView.image = [UIImage imageNamed:@"owner_ControlTypeAuto"];
                break;
            default:
                break;
        }
        
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UIButton *)button
{
    if (_button == nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = self.bounds;
        
        _button = button;
    }
    
    return _button;
}


@end
