//
//  CarOneStatus.m
//  OBD
//
//  Created by Why on 16/3/30.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "CarOneStatus.h"

@interface CarOneStatus()
@property (nonatomic,strong)UIImageView * backImageView;
/**
 *  转速
 */
@property (nonatomic,strong)UILabel * turnSpeed;
/**
 *  车速
 */
@property (nonatomic,strong)UILabel * carSpeed;
/**
 *  水温
 */
@property (nonatomic,strong)UILabel * waterTemp;
@end
@implementation CarOneStatus
{
    float _width;
    float _height;
    float _oneTop;//88
    float _twoTop;//70
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _oneTop = 80;
        _twoTop = 70;
        _width = frame.size.width;
        _height = frame.size.height;
        //self.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.backImageView];
        [self addOrginalLable];
        [self change];
    }
    return self;
}
- (void)change{
    [[CurrentOBDModel sharedCurrentOBDModel]obdWaterTempChangeWithBlock:^(NSString *waterTemp) {
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            self.waterTemp.text = waterTemp;
        }
        
    }];
    [[CurrentOBDModel sharedCurrentOBDModel]obdTurnSpeedChangeWithBlock:^(NSString *turnSpeed) {
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            self.turnSpeed.text = turnSpeed;
        }
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        
    }];
    [[CurrentOBDModel sharedCurrentOBDModel]obdCarSpeedChangeWithBlock:^(NSString *carSpeed) {
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            self.carSpeed.text = carSpeed;
        }
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        
    }];
}
- (void)addOrginalLable{
    /**
     *字体
     */
    float font = 10;
    if (isiPhone5) {
        font = 10;
    }else if (isiPhone6){
        font = 12;
    }else if (isiPhone6P){
        font = 13;
    }
    
    float wid = 35;
    if (isiPhone5) {
        wid = 30;
    }
    UILabel * turnSpLable = [self getLableWithframe:CGRectMake([WHYSizeManager getRelativelyWeight:wid], [WHYSizeManager getRelativelyHeight:_oneTop], [WHYSizeManager getRelativelyWeight:80], 40) textStr:[self getAttributeStr:WHYGetStringWithKeyFromTable(@"TURNSPEED", @"") unChangeLength:5 unchangeStr:@"(r/min)"] font:font];
    [self addSubview:turnSpLable];

    float left = 15.0;
    if (ScreenWidth<=320) {
        left = 0;
    }
    
    
    UILabel * speedLable = [self getLableWithframe:CGRectMake(turnSpLable.frame.origin.x+turnSpLable.frame.size.width+left, [WHYSizeManager getRelativelyHeight:_twoTop], [WHYSizeManager getRelativelyWeight:160], 30) textStr:[self getAttributeStr:WHYGetStringWithKeyFromTable(@"CARSPEED", @"") unChangeLength:4 unchangeStr:@"(km/h)"] font:15];
//    speedLable.backgroundColor = [UIColor redColor];
    [self addSubview:speedLable];
    
    UILabel * waterTempLable = [self getLableWithframe:CGRectMake(ScreenWidth-[WHYSizeManager getRelativelyWeight:50]-25, [WHYSizeManager getRelativelyHeight:_oneTop], [WHYSizeManager getRelativelyWeight:60], 40) textStr:[self getAttributeStr:WHYGetStringWithKeyFromTable(@"WARTERTEMP", @"") unChangeLength:1 unchangeStr:@"(℃)"] font:font];
    [self addSubview:waterTempLable];
    
    
    self.turnSpeed = [self getNumLableWithframe:CGRectMake([WHYSizeManager getRelativelyWeight:wid], [WHYSizeManager getRelativelyHeight:_oneTop+32], [WHYSizeManager getRelativelyWeight:80], 30) textStr:@"0" font:20];
    [self addSubview:self.turnSpeed];
    
    self.carSpeed = [self getNumLableWithframe:CGRectMake(turnSpLable.frame.origin.x+turnSpLable.frame.size.width, [WHYSizeManager getRelativelyHeight:_twoTop+40], [WHYSizeManager getRelativelyWeight:180], 30) textStr:@"0" font:30];
    [self addSubview:self.carSpeed];
    
    self.waterTemp = [self getNumLableWithframe:CGRectMake(ScreenWidth-[WHYSizeManager getRelativelyWeight:50]-25, [WHYSizeManager getRelativelyHeight:_twoTop+40], [WHYSizeManager getRelativelyWeight:60], 30) textStr:@"0" font:20];
    [self addSubview:self.waterTemp];
}

- (NSMutableAttributedString*)getAttributeStr:(NSString*)oldStr unChangeLength:(NSInteger)len unchangeStr:(NSString*)unchangeStr{
    float lenght = oldStr.length; //
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",oldStr,unchangeStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"219dd0"] range:NSMakeRange(0, lenght+1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"a0b751"] range:NSMakeRange(lenght+1, len)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"219dd0"] range:NSMakeRange(lenght+1+len, 1)];
    return str;
}
- (UIImageView*)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
        _backImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backImageView.image = [UIImage imageNamed:@"obd_yibiaopan"];
        _backImageView.clipsToBounds = YES;
    }
    return _backImageView;
}

- (UILabel*)getLableWithframe:(CGRect)frame textStr:(NSMutableAttributedString*)str font:(NSInteger)font{
    UILabel * checkLable = [[UILabel alloc]initWithFrame:frame];
   // checkLable.backgroundColor = [UIColor blueColor];
    
    checkLable.numberOfLines = 2;
    //checkLable.textColor = color;
    checkLable.font = [UIFont systemFontOfSize:font];
    checkLable.attributedText = str;
    checkLable.textAlignment = NSTextAlignmentCenter;
    return checkLable;
}
- (UILabel*)getNumLableWithframe:(CGRect)frame textStr:(NSString*)str font:(NSInteger)font{
    UILabel * checkLable = [[UILabel alloc]initWithFrame:frame];
    checkLable.textColor = [UIColor colorConvertWithHexString:@"a0b751"];
    checkLable.font = [UIFont fontWithName:@"DBLCDTempBlack" size:font];
    checkLable.text = str;
    checkLable.textAlignment = NSTextAlignmentCenter;
    return checkLable;
}

@end
