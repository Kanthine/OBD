//
//  CarTwoStatus.m
//  OBD
//
//  Created by Why on 16/3/31.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "CarTwoStatus.h"
#import "LineView.h"
@interface CarTwoStatus()
@property(nonatomic,strong)UIImageView * leftImageView;
/**
 *  空燃比
 */
@property(nonatomic,strong)UILabel * kongRBLable;
/**
 *  进气压力
 */
@property(nonatomic,strong)LineView * intakePressure;
/**
 *  进气流量
 */
@property(nonatomic,strong)LineView * intakeFlue;
/**
 *  进气温度
 */
@property(nonatomic,strong)LineView * intakeTemp;
/**
 *  排气温度
 */
@property(nonatomic,strong)LineView * exhaustTemp;

/**
 *  进气压力lable
 */
@property (nonatomic,strong)UILabel * intakePressureLable;
/**
 *  进气流量lable
 */
@property (nonatomic,strong)UILabel * intakeFlueLable;
/**
 *  进气温度lable
 */
@property (nonatomic,strong)UILabel * intakeTempLable;
/**
 *  排气温度lable
 */
@property (nonatomic,strong)UILabel * exhaustTempLable;
@end
@implementation CarTwoStatus
{
    float _width;
    NSString * _baiFenStr;
    /**
     *  柱状长条图长度
     */
    float _colorWidth;
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
        
        _baiFenStr = @"%";
        _width = [WHYSizeManager getRelativelyWeight:120];
        _colorWidth = ScreenWidth-_width-67;
        [self addSubview:self.leftImageView];
        [self addSubview:self.kongRBLable];
        [self setUpView];
        [self addNotigation];
    }
    return self;
}
- (void)addNotigation{
    //空燃比
    [[CurrentOBDModel sharedCurrentOBDModel]obdFuelRatioChangeWithBlock:^(NSString *fuelRatio) {
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            if (fuelRatio != nil) {
                self.kongRBLable.text = [NSString stringWithFormat:@"%@\n%@%@",WHYGetStringWithKeyFromTable(@"KONGRANBI", @""),fuelRatio,_baiFenStr];
            }
        }
       
    }];
    //进气压力
    [[CurrentOBDModel sharedCurrentOBDModel]obdIntakePressureChangeWithBlock:^(NSString *intakePressure) {
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            if (intakePressure != nil) {
                self.intakePressureLable.text = [NSString stringWithFormat:@"%@kPa",intakePressure];
                self.intakePressure.currentValue = [intakePressure floatValue];
            }
        }
        
    }];
    //进气流量
    [[CurrentOBDModel sharedCurrentOBDModel]obdIntakeFlueChangeWithBlock:^(NSString *intakeFlue) {
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            if (intakeFlue != nil) {
                
                self.intakeFlueLable.text = [NSString stringWithFormat:@"%@g/S",intakeFlue];
                self.intakeFlue.currentValue = [intakeFlue floatValue];
            }
        }
       
    }];
    //进气温度
    [[CurrentOBDModel sharedCurrentOBDModel]obdIntakeTempChangeWithBlock:^(NSString *intakeTemp) {
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
        if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            if (intakeTemp != nil) {
                self.intakeTempLable.text = [NSString stringWithFormat:@"%@℃",[NSString stringWithFormat:@"%ld",[intakeTemp integerValue]-40]];
                self.intakeTemp.currentValue = [intakeTemp floatValue]-40.0;
            }

        }
        
    }];
//    //排气温度
//    [[CurrentOBDModel sharedCurrentOBDModel]obdExhaustTempChangeWithBlock:^(NSString *exhaustTemp) {
//        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//            return ;
//        }
//        if (exhaustTemp != nil) {
//            self.exhaustTempLable.text = [NSString stringWithFormat:@"%@℃",exhaustTemp];
//            self.exhaustTemp.currentValue = [exhaustTemp floatValue];
//        }
//    }];
}
- (void)setUpView{
    NSArray * colorArr = @[[UIColor colorConvertWithHexString:@"ffbc38"],[UIColor colorConvertWithHexString:@"eb4549"],[UIColor colorConvertWithHexString:@"25d1d7"]];//,[UIColor colorConvertWithHexString:@"2095f2"]
    NSArray * rangeArr = @[@"200",@"100",@"100"];//,@"255"
    NSArray * titleArr = @[WHYGetStringWithKeyFromTable(@"JINGQIYALI", @""),WHYGetStringWithKeyFromTable(@"JINQILIULIANG", @""),WHYGetStringWithKeyFromTable(@"JINQIWENDU", @""),WHYGetStringWithKeyFromTable(@"PAIQIWENDU", @"")];
    for (int i = 0; i<rangeArr.count; i++) {
        float y = [WHYSizeManager getRelativelyHeight:30]+[WHYSizeManager getRelativelyHeight:45]*i;
        UILabel * lable = [self getLableWithFrame:CGRectMake(_width+42, y, 160, 20) str:titleArr[i] font:[self getTitleFont] textAlignment:NSTextAlignmentLeft];
         UILabel * detailLable = [self getLableWithFrame:CGRectMake(ScreenWidth-125, y, 100, 20) str:@"0" font:[self getTitleFont] textAlignment:NSTextAlignmentRight];
        LineView * view = [[LineView alloc]initWithFrame:CGRectMake(_width+42, lable.frame.origin.y+lable.frame.size.height+4,_colorWidth , 5) totalWidth:_colorWidth numberRange:[rangeArr[i] floatValue ]color:colorArr[i]];
        view.backgroundColor = [UIColor whiteColor];
        switch (i) {
            case 0:
            {
                self.intakePressureLable = detailLable;
                self.intakePressure = view;
            }
                break;
            case 1:
            {
                self.intakeFlueLable = detailLable;
                self.intakeFlue = view;
            }
                break;
            case 2:
            {
                self.intakeTempLable = detailLable;
                self.intakeTemp = view;
            }
                break;
//            case 3:
//            {
//                self.exhaustTempLable = detailLable;
//                self.exhaustTemp = view;
//            }
                break;
                
            default:
                break;
        }
        [self addSubview:lable];
        [self addSubview:detailLable];
        [self addSubview:view];
    }
    
    
}
- (UILabel*)getLableWithFrame:(CGRect)frame str:(NSString*)str font:(NSInteger)font textAlignment:(NSTextAlignment)alingment{
    UILabel * lable = [[UILabel alloc]initWithFrame:frame];
    lable.textAlignment = alingment;
    lable.textColor = [UIColor whiteColor];
    lable.text = str;
    lable.font = [UIFont systemFontOfSize:font];
    return lable;
}
- (UIImageView*)leftImageView{
    if (!_leftImageView) {
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (self.frame.size.height-_width)/2.0, _width, _width)];
        _leftImageView.image = [UIImage imageNamed:@"obd_kongranbi"];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
}

- (UILabel*)kongRBLable{
    if (!_kongRBLable) {
        _kongRBLable = [[UILabel alloc]init];
        _kongRBLable.frame = CGRectMake([WHYSizeManager getRelativelyWeight:78], [WHYSizeManager getRelativelyHeight:70], [WHYSizeManager getRelativelyWeight:50], [WHYSizeManager getRelativelyHeight:45]);
        _kongRBLable.numberOfLines = 3;
        _kongRBLable.textColor = [UIColor whiteColor];
//        _kongRBLable.backgroundColor = [UIColor redColor];
        _kongRBLable.font = [UIFont systemFontOfSize:[self getTextFont]];
        _kongRBLable.textAlignment = NSTextAlignmentCenter;
        _kongRBLable.text = [NSString stringWithFormat:@"%@\n14.7",WHYGetStringWithKeyFromTable(@"KONGRANBI", @"")];
    }
    return _kongRBLable;
}

- (NSInteger)getTextFont{
    NSInteger font = 10;
    if (isiPhone5) {
        font = 11;
    }else if (isiPhone6){
        font = 12;
    }else if (isiPhone6P){
        font = 13;
    }
    return font;
}

- (NSInteger)getTitleFont{
    NSInteger font = 8;
    if (isiPhone5) {
        font = 8;
    }else if (isiPhone6){
        font = 9;
    }else if (isiPhone6P){
        font = 11;
    }
    return font;
//    NSInteger font = 10;
//    if (isiPhone5) {
//        font = 12;
//    }else if (isiPhone6){
//        font = 14;
//    }else if (isiPhone6P){
//        font = 15;
//    }
//    return font;
}
@end
