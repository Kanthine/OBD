//
//  ThreeItemView.m
//  OBD
//
//  Created by Why on 16/3/28.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "ThreeItemView.h"
@interface ThreeItemView()
@property(nonatomic,strong)UIView * yellowView;
@property(nonatomic,strong)UIView * blueView;
@property(nonatomic,strong)UIView * redView;
@property(nonatomic,strong)UIImageView * middleBackImageView;
@property(nonatomic,strong)UILabel * middle_SwithStatusLable;
@end
@implementation ThreeItemView
{
    float _width;
    float _height;
    NSInteger _StatusNum;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _width = [WHYSizeManager getRelativelyWeight:65];
        _height = [WHYSizeManager getRelativelyWeight:61];
        [self setUpView];
    }
    return self;
}
- (void)setUpView
{
    [self addSubview:self.yellowView];
    [self addSubview:self.blueView];
    [self addSubview:self.redView];
    
    __weak __typeof__(self) weakSelf = self;
    
    [CurrentOBDModel sharedCurrentOBDModel].switchStatus = @"MANOFF";
    
    [self setViewStatus:[CurrentOBDModel sharedCurrentOBDModel].processStatus];
    
    [[CurrentOBDModel sharedCurrentOBDModel]obdBluetoothSwitchChangeWithBlock:^(NSString *bluethOn)
    {
        [weakSelf setViewStatus:bluethOn];
    }];
    
    [[CurrentOBDModel sharedCurrentOBDModel]obdErrorcodeNumChangeBlock:^(NSString *errcodeNum)
     {
        if (errcodeNum != nil)
        {
            _errorcodeLable.text = errcodeNum;
        }
    }];
}


- (void)setViewStatus:(NSString *)bluethOn
{
    if ([bluethOn isEqualToString:@"1"])//蓝牙关闭
    {
        _redView.hidden = YES;
        _middleBackImageView.image = [UIImage imageNamed:@"kaiqilanya"];
        _middle_SwithStatusLable.hidden = YES;
        _middleLable.text = WHYGetStringWithKeyFromTable(@"OPENLANYA", @"");
    }
    else if ([bluethOn isEqualToString:@"2"])//蓝牙打开
    {
        _redView.hidden = YES;
        _middleBackImageView.image = [UIImage imageNamed:@"lianjieobd"];
        _middle_SwithStatusLable.hidden = YES;
        _middleLable.text = WHYGetStringWithKeyFromTable(@"LINE", @"");
    }
    else if ([bluethOn isEqualToString:@"3"])//链接到外部设备
    {
        _redView.hidden = NO;
        _middleBackImageView.image = [UIImage imageNamed:@"switchBg"];
        _middle_SwithStatusLable.hidden = NO;
        [self changeMiddleValue];//改变中间按钮的字体状态
        _StatusNum = 1;
        [self performSelector:@selector(checkCarStatus) withObject:self afterDelay:2];
        _middleLable.text = WHYGetStringWithKeyFromTable(@"SWITCH", @"");
    }
}

#pragma mark --改变中间按钮的状态 on off auto--
- (void)changeMiddleValue
{
     NSString * switchStr;
    switch ([CurrentOBDModel sharedCurrentOBDModel].switchStatusNum)
    {
        case 0:
        {
             switchStr = @"ON";
        }
            break;
        case 1:
        {
             switchStr = @"OFF";
        }
            break;
        case 2:
        {
            switchStr = @"AUTO";
        }
            break;
            
        default:
            break;
    }
    
    if ([[CurrentOBDModel sharedCurrentOBDModel].processStatus isEqualToString:@"3"])
    {
        _middle_SwithStatusLable.text = switchStr;
    }
}
#pragma mark --左边的view--
- (UIView*)yellowView
{
    if (_yellowView == nil)
    {
        _yellowView = [[UIView alloc]initWithFrame:CGRectMake(25, 10, _width, _height)];
        
        [_yellowView addSubview:[self getImageViewWithFrame:CGRectMake(0, 0, _width, _height) imageStr:@"huangse"]];
        
        [_yellowView addSubview:[self getLableWithframe:CGRectMake(0, 4, _width-8, [WHYSizeManager getRelativelyHeight:15]) textStr:WHYGetStringWithKeyFromTable(@"CHECK", @"") textColor:[UIColor blackColor]]];
        
        [_yellowView addSubview:self.checkButton];
    }
    return _yellowView;
}
- (UIImageView*)getImageViewWithFrame:(CGRect)frame imageStr:(NSString*)str{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:str];
    imageView.userInteractionEnabled = YES;
    return imageView;
}
- (UILabel*)getLableWithframe:(CGRect)frame textStr:(NSString*)str textColor:(UIColor*)color{
    UILabel * checkLable = [[UILabel alloc]initWithFrame:frame];
    float font = 10;
    if (isiPhone5) {
        font = 9;
    }else if (isiPhone6){
        font = 10;
    }else if (isiPhone6P){
        font = 12;
    }
    checkLable.textColor = color;
    checkLable.font = [UIFont systemFontOfSize:font];
    checkLable.text = str;
    checkLable.textAlignment = NSTextAlignmentRight;
    return checkLable;
}
- (UIButton*)checkButton{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(0, 0, _width, _height);
        _checkButton.tag = 109;
        [_checkButton addTarget:self action:@selector(buttonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}
#pragma mark --中间的view--
- (UIView*)blueView{
    if (!_blueView) {
        _blueView = [[UIView alloc]initWithFrame:CGRectMake(_width+35, 10, _width, _height)];
        [_blueView addSubview:self.middleBackImageView];
        [_blueView addSubview:self.middle_SwithStatusLable];
        [_blueView addSubview:self.middleLable];
        [_blueView addSubview:self.switchButton];
    }
    return _blueView;
}
- (UIImageView*)middleBackImageView{
    if (!_middleBackImageView) {
        _middleBackImageView = [self getImageViewWithFrame:CGRectMake(0, 0, _width, _height) imageStr:@"kaiqilanya"];
        _middleBackImageView.userInteractionEnabled = YES;
    }
    return _middleBackImageView;
}
- (UIButton*)switchButton{
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.frame = CGRectMake(0, 0, _width, _height);
        _switchButton.tag = 99;
        [_switchButton addTarget:self action:@selector(buttonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
       // [_switchButton setImage:[UIImage imageNamed:@"kaiqilanya"] forState:UIControlStateNormal];
    }
    return _switchButton;
}
- (UILabel*)middleLable{
    if (!_middleLable) {
        _middleLable = [self getLableWithframe:CGRectMake(8, 4, _width-8, [WHYSizeManager getRelativelyHeight:15]) textStr:WHYGetStringWithKeyFromTable(@"OPENLANYA", @"") textColor:[UIColor whiteColor]];
        _middleLable.textAlignment = NSTextAlignmentRight;
    }
    return _middleLable;
}
- (UILabel*)middle_SwithStatusLable{
    if (!_middle_SwithStatusLable) {
        float font = 9;
        float top = 26;
        if (isiPhone6P) {
            font = 13;
            top = 32;
        }else if (isiPhone6){
            font = 11;
            top = 30;
        }
        _middle_SwithStatusLable = [[UILabel alloc]initWithFrame:CGRectMake(_width/2.0-5, _height-top, _width/2.0, 25)];
        _middle_SwithStatusLable.textAlignment = NSTextAlignmentRight;
        _middle_SwithStatusLable.textColor = [UIColor whiteColor];
        _middle_SwithStatusLable.font = [UIFont systemFontOfSize:font];
        _middleLable.hidden = YES;
    }
    return _middle_SwithStatusLable;
}
#pragma mark --右边view--
- (UIView*)redView{
    if (!_redView) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(_width*2+45, 10, _width, _height)];
        _redView.hidden = YES;
        [_redView addSubview:[self getImageViewWithFrame:CGRectMake(0, 0, _width, _height) imageStr:@"errorcode"]];
        [_redView addSubview:[self getLableWithframe:CGRectMake(0, 4, _width-8, [WHYSizeManager getRelativelyHeight:15]) textStr:WHYGetStringWithKeyFromTable(@"ERRORCODE", @"") textColor:[UIColor whiteColor]]];
        [_redView addSubview:self.errorcodeLable];
        [_redView addSubview:self.errcodeButton];
    }
    return _redView;
}

- (UIButton*)errcodeButton{
    if (!_errcodeButton) {
        _errcodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _errcodeButton.frame = CGRectMake(0, 0, _width, _height);
        _errcodeButton.tag = 110;
         [_errcodeButton addTarget:self action:@selector(buttonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _errcodeButton;
}

- (UILabel*)errorcodeLable{
    if (!_errorcodeLable) {
        _errorcodeLable = [[UILabel alloc]initWithFrame:CGRectMake(_width/2.0-5, _height-25, _width/2.0, 20)];
        _errorcodeLable.textAlignment = NSTextAlignmentRight;
        _errorcodeLable.textColor = [UIColor whiteColor];
        _errorcodeLable.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:18];
        _errorcodeLable.text = @"0";
    }
    return _errorcodeLable;
}
#pragma mark --按钮点击事件--
- (void)buttonClickWithTag:(UIButton*)btn
{
    switch (btn.tag) {
        case 99:
        {

            if ([[CurrentOBDModel sharedCurrentOBDModel].processStatus isEqualToString:@"1"])
            {
                //蓝牙没开启时 点击去设置界面打开蓝牙
                NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
                    [[UIApplication sharedApplication] openURL:url];
                }

            }
            else if ([[CurrentOBDModel sharedCurrentOBDModel].processStatus isEqualToString:@"3"])
            {
                //已经连接到obd了 点击跳转到开关界面
                if ([self.delegate respondsToSelector:@selector(threeItemSelect:)])
                {
                    [self.delegate threeItemSelect:1];
                }
            }
        }
            break;
        case 109:
        {
            // 黄色按钮
            /**
             *  查看数据知识
             */
            if ([[CurrentOBDModel sharedCurrentOBDModel].processStatus isEqualToString:@"3"])
            {
                if ([self.delegate respondsToSelector:@selector(threeItemSelect:)])
                {
                    [self.delegate threeItemSelect:0];
                }
            }
            else
            {
                
                Alert(@"您还没有连接到OBD哦");
            }
            
        }
            break;
        case 110:
        {
            /**
             *  查看故障码
             */
            if ([self.delegate respondsToSelector:@selector(threeItemSelect:)]) {
                [self.delegate threeItemSelect:2];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark --查询命令--
- (void)checkCarStatus{
    [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:8 isCheck:YES newOrder:nil];
   [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:2 isCheck:YES newOrder:@""];
    [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:0 isCheck:YES newOrder:nil];
}

@end
