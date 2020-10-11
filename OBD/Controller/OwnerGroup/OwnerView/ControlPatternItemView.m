//
//  ControlPatternItemView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "ControlPatternItemView.h"

@interface ControlPatternItemView()

@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIView *contentView;


@end

@implementation ControlPatternItemView

- (void)dealloc
{
    [_configurationModel removeObserver:self forKeyPath:@"rotateSpeedStr"];
    [_configurationModel removeObserver:self forKeyPath:@"valveDelayStr"];
    [_configurationModel removeObserver:self forKeyPath:@"isDefault"];
    _configurationModel = nil;
}

- (instancetype)initWithFrame:(CGRect)frame PatternType:(BoxControlAutoPattern)patternType
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _configurationModel = [[BoxControlAutoModelConfiguration alloc]initWithConfigurationType:patternType];

        
        [_configurationModel addObserver:self forKeyPath:@"rotateSpeedStr" options:NSKeyValueObservingOptionNew context:nil];
        [_configurationModel addObserver:self forKeyPath:@"valveDelayStr" options:NSKeyValueObservingOptionNew context:nil];
        [_configurationModel addObserver:self forKeyPath:@"isDefault" options:NSKeyValueObservingOptionNew context:nil];

        
        [self addSubview:self.topView];
        [self updateTopSelectedInfo];
        
        [self addSubview:self.contentView];
    }
    
    return self;
}

- (UIView *)topView
{
    if (_topView == nil)
    {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 50)];
        topView.backgroundColor = [UIColor clearColor];
        
        
        
        
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.tag = 1;
        titleLable.textAlignment = NSTextAlignmentRight;
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.text = self.configurationModel.autoNameString;
        [topView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.centerX.equalTo(topView.mas_centerX).with.offset(20);
        }];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.configurationModel.autoLogoString] highlightedImage:[UIImage imageNamed:self.configurationModel.autoSelectedLogoString]];
        imageView.tag = 2;
        imageView.highlighted = self.configurationModel.isDefault;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [topView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.right.equalTo(titleLable.mas_left).with.offset(-5);
        }];

        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(setDefaultPatternButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(topView);
        }];

        
        _topView = topView;
    }
    
    return _topView;
}

- (UIView *)contentView
{
    if (_contentView == nil)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.topView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.topView.frame))];
        view.backgroundColor = RGBA(64, 64, 64, 1);

        
        UILabel *topLeftLable = [[UILabel alloc]init];
        topLeftLable.text = @"设置转速：";
        topLeftLable.textColor = RGBA(254, 210, 45, 1);
        topLeftLable.textAlignment = NSTextAlignmentRight;
        topLeftLable.font = [UIFont systemFontOfSize:14];
        topLeftLable.backgroundColor = [UIColor clearColor];
        [view addSubview:topLeftLable];
        [topLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        UILabel *topRightLable = [[UILabel alloc]init];
        topRightLable.text = self.configurationModel.rotateSpeedStr;
        topRightLable.tag = 2;
        topRightLable.textColor = RGBA(254, 210, 45, 1);
        topRightLable.textAlignment = NSTextAlignmentRight;
        topRightLable.font = [UIFont systemFontOfSize:14];
        topRightLable.backgroundColor = [UIColor clearColor];
        [view addSubview:topRightLable];
        [topRightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.equalTo(topLeftLable.mas_right).with.offset(0);
        }];
        
        UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableCellRight"]];
        imageView1.transform=CGAffineTransformMakeRotation(M_PI / 2.0);
        imageView1.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView1];
        [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-10);
        }];

        
        UILabel *bottomLeftLable = [[UILabel alloc]init];
        bottomLeftLable.text = @"阀门延迟：";
        bottomLeftLable.textColor = RGBA(254, 210, 45, 1);
        bottomLeftLable.textAlignment = NSTextAlignmentRight;
        bottomLeftLable.font = [UIFont systemFontOfSize:14];
        bottomLeftLable.backgroundColor = [UIColor clearColor];
        [view addSubview:bottomLeftLable];
        [bottomLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLeftLable.mas_bottom).with.offset(10);
            make.left.mas_equalTo(10);
        }];
        
        UILabel *bottomRightLable = [[UILabel alloc]init];
        bottomRightLable.tag = 4;
        bottomRightLable.text = self.configurationModel.valveDelayStr;
        bottomRightLable.textColor = RGBA(254, 210, 45, 1);
        bottomRightLable.textAlignment = NSTextAlignmentRight;
        bottomRightLable.font = [UIFont systemFontOfSize:14];
        bottomRightLable.backgroundColor = [UIColor clearColor];
        [view addSubview:bottomRightLable];
        [bottomRightLable mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(topLeftLable.mas_bottom).with.offset(10);
            make.left.equalTo(bottomLeftLable.mas_right).with.offset(0);
        }];
        
        UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableCellRight"]];
        imageView2.transform=CGAffineTransformMakeRotation(M_PI / 2.0);
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView2];
        [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLeftLable.mas_bottom).with.offset(13);
            make.right.mas_equalTo(-10);
        }];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(setConfigurationModelDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        
        _contentView = view;
    }
    
    return _contentView;
}

- (void)setConfigurationModelDataButtonClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(configurationModelDataClick:)])
    {
        [self.delegate configurationModelDataClick:_configurationModel];
    }
}

- (void)setDefaultPatternButtonClick
{
    if (_configurationModel.isDefault == NO)
    {
        NSLog(@"设置%@为默认模式",_configurationModel.autoNameString);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(setDefaultPatternClick:)])
        {
            [self.delegate setDefaultPatternClick:self];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSString *newkey = [NSString stringWithFormat:@"%@",change[NSKeyValueChangeNewKey]];

    NSLog(@"keyPath:%@ -------- change: %@",keyPath,change);
    
    
    if ([keyPath isEqualToString:@"rotateSpeedStr"])
    {
        UILabel *topRightLable = [self.contentView viewWithTag:2];
        topRightLable.text = newkey;
    }
    else if ([keyPath isEqualToString:@"valveDelayStr"])
    {
        UILabel *bottomRightLable = [self.contentView viewWithTag:4];
        bottomRightLable.text = newkey;
    }
    else if ([keyPath isEqualToString:@"isDefault"])
    {
        BOOL isDefault = [newkey boolValue];
        [self updateTopSelectedInfo];
    }
}

- (void)updateTopSelectedInfo
{
    UILabel *titleLable = [self.topView viewWithTag:1];
    UIImageView *imageView = [self.topView viewWithTag:2];
    imageView.highlighted = _configurationModel.isDefault;
    
    
    if (_configurationModel.isDefault)
    {
        titleLable.textColor = [UIColor whiteColor];
    }
    else
    {
        titleLable.textColor = RGBA(151, 151, 151, 1);
    }
}

@end
