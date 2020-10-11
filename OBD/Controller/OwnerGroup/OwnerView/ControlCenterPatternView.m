//
//  ControlCenterPatternView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/22.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "ControlCenterPatternView.h"
#import "BoxControlAutoModelConfiguration.h"


@interface ControlCenterPatternView()

{
    BoxControlAutoPattern _patternType;
}

@property (nonatomic ,assign) BoxControlAutoPattern patternType;
@property (nonatomic ,strong) UILabel *titleLable;

@end

@implementation ControlCenterPatternView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGBA(64, 64, 64, 1);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetHeight(frame) / 2.0;
        
        [self addSubview:self.titleLable];
        
        [self setPatternButton];
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
        
        _titleLable = lable;
    }
    
    return _titleLable;
}

- (void)setPatternButton
{
    CGFloat space = 5;
    CGFloat height = CGRectGetHeight(self.frame) - space * 2;
    CGFloat superWidth = CGRectGetWidth(self.frame);
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.tag = 12;
    rightButton.frame = CGRectMake(superWidth - height - space, space, height, height);
    [rightButton setImage:[UIImage imageNamed:@"owner_PatternTypeSport"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"owner_PatternTypeSport_Selected"] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(patternButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:rightButton];
    
    
    superWidth = rightButton.frame.origin.x;
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerButton.tag = 11;
    centerButton.frame = CGRectMake(superWidth - height - space, space, height, height);
    [centerButton setImage:[UIImage imageNamed:@"owner_PatternTypeGeneral"] forState:UIControlStateNormal];
    [centerButton setImage:[UIImage imageNamed:@"owner_PatternTypeGeneral_Selected"] forState:UIControlStateSelected];
    [centerButton addTarget:self action:@selector(patternButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    centerButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:centerButton];
    
    superWidth = centerButton.frame.origin.x;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag = 10;
    leftButton.frame = CGRectMake(superWidth - height - space, space, height, height);
    [leftButton setImage:[UIImage imageNamed:@"owner_PatternTypeComfortable"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"owner_PatternTypeComfortable_Selected"] forState:UIControlStateSelected];

    [leftButton addTarget:self action:@selector(patternButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:leftButton];
}

- (void)patternButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 10:
            [LocalConfigurationData setBoxControlAutoPattern:BoxControlAutoPatternComfortable];
            break;
        case 11:
            [LocalConfigurationData setBoxControlAutoPattern:BoxControlAutoPatternGeneral];
            break;
        case 12:
            [LocalConfigurationData setBoxControlAutoPattern:BoxControlAutoPatternSport];
            break;
        default:
            break;
    }
    
    [self updateControlCenterPatternInfo];
}



- (void)updateControlCenterPatternInfo
{
    BoxControlAutoModelConfiguration *defaultBoxModel = [[BoxControlAutoModelConfiguration alloc]initWithConfigurationType:[LocalConfigurationData getBoxControlPattern]];
    
    
    if ([self.titleLable.text isEqualToString:defaultBoxModel.autoNameString] == NO)
    {
        self.titleLable.text = defaultBoxModel.autoNameString;
        
        
        UIButton *leftButton = [self viewWithTag:10];
        UIButton *centerButton = [self viewWithTag:11];
        UIButton *rightButton = [self viewWithTag:12];
        
        switch ([LocalConfigurationData getBoxControlPattern])
        {
            case BoxControlAutoPatternComfortable:
                leftButton.selected = YES;
                centerButton.selected = NO;
                rightButton.selected = NO;
                break;
            case BoxControlAutoPatternGeneral:
                leftButton.selected = NO;
                centerButton.selected = YES;
                rightButton.selected = NO;
                break;
            case BoxControlAutoPatternSport:
                leftButton.selected = NO;
                centerButton.selected = NO;
                rightButton.selected = YES;
                break;
            default:
                break;
        }
    }
    
    
    [self updateOBDModelData:defaultBoxModel];
}


//设置转速阀值、阀门延迟
- (void)updateOBDModelData:(BoxControlAutoModelConfiguration *)defaultBoxModel
{
    if ([[CurrentOBDModel sharedCurrentOBDModel].checkTurnSpeed isEqualToString:defaultBoxModel.rotateSpeedStr] == NO)
    {
        //设置转速阀值
        [CurrentOBDModel sharedCurrentOBDModel].checkTurnSpeed = defaultBoxModel.rotateSpeedStr;
        [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:1 isCheck:NO newOrder:defaultBoxModel.rotateSpeedStr];
    }
    
    
    
    
    if ([[CurrentOBDModel sharedCurrentOBDModel].delayTime isEqualToString:defaultBoxModel.valveDelayStr] == NO)
    {
        //设置阀门延迟
        [CurrentOBDModel sharedCurrentOBDModel].delayTime = defaultBoxModel.valveDelayStr;
        [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:13 isCheck:NO newOrder:defaultBoxModel.valveDelayStr];
    }
}

@end

