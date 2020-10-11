//
//  StatusTwoView.m
//  OBD
//
//  Created by Why on 16/4/5.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "StatusTwoView.h"

@implementation StatusTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self addSubview:self.iconImageView];
        [self addSubview:self.tishiLable];
    }
    return self;
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView)
    {
        float _width = [WHYSizeManager getRelativelyWeight:13];
        float _height = [WHYSizeManager getRelativelyWeight:20];
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake([WHYSizeManager getRelativelyWeight:120], 10, _width, _height)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"lingdang_on"];
    }
    return _iconImageView;
}

- (UILabel*)tishiLable{
    if (!_tishiLable) {
        _tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.frame.origin.x+_iconImageView.frame.size.width+12, 10, 200, 20)];
        _tishiLable.textAlignment = NSTextAlignmentLeft;
        _tishiLable.font = [UIFont systemFontOfSize:15];
        _tishiLable.text = @"您的设备已开启";
        _tishiLable.textColor = [UIColor colorConvertWithHexString:@"0af5fa"];
    }
    return _tishiLable;
}

- (void)changeStatusWithSwitch:(NSInteger)status{
    NSString * colorStr;
    NSString * imageStr;
    NSString * titleStr;
    switch (status) {
        case 0:
        {
            colorStr = @"0af5fa";
            titleStr = WHYGetStringWithKeyFromTable(@"SWITCHON", @"");
            imageStr = @"lingdang_on";
        }
            break;
        case 1:
        {
            colorStr = @"e61c35";
            titleStr = WHYGetStringWithKeyFromTable(@"SWITCHOFF", @"");
            imageStr = @"lingdang_off";
        }
            break;
        case 2:
        {
            colorStr = @"f7bf0c";
            titleStr = WHYGetStringWithKeyFromTable(@"SWITCHAUTO", @"");
            imageStr = @"lingdang_auto";
        }
            break;
            
        default:
            break;
    }
    _tishiLable.text = titleStr;
    _tishiLable.textColor = [UIColor colorConvertWithHexString:colorStr];
    _iconImageView.image = [UIImage imageNamed:imageStr];
    
}
@end
