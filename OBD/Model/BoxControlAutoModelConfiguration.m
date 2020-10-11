//
//  BoxControlAutoModelConfiguration.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/22.
//  Copyright © 2017年 苏沫离. All rights reserved.
//


#define UserDefaults [NSUserDefaults standardUserDefaults]

#define RotateSpeedKey @"RotateSpeedKey"
#define ValveDelayKey @"ValveDelayKey"


#import "BoxControlAutoModelConfiguration.h"

@interface BoxControlAutoModelConfiguration()

{
    NSString *_localKeyStr;

    
    NSString *_rotateSpeedStr;
    NSString *_valveDelayStr;
    BOOL _isDefault;
}

@end


@implementation BoxControlAutoModelConfiguration

- (instancetype)initWithConfigurationType:(BoxControlAutoPattern)autoType
{
    self = [super init];
    
    if (self)
    {
        _autoType = autoType;
        
        
        switch (autoType)
        {
            case BoxControlAutoPatternComfortable:
                _localKeyStr = @"BoxControlAutoPatternComfortable";
                _autoNameString = @"舒适模式";
                _autoLogoString = @"owner_PatternTypeComfortable";
                _autoSelectedLogoString = @"owner_PatternTypeComfortable_Selected";
                break;
            case BoxControlAutoPatternGeneral:
                _localKeyStr = @"BoxControlAutoPatternGeneral";
                _autoNameString = @"普通模式";
                _autoLogoString = @"owner_PatternTypeGeneral";
                _autoSelectedLogoString = @"owner_PatternTypeGeneral_Selected";
                break;
            case BoxControlAutoPatternSport:
                _localKeyStr = @"BoxControlAutoPatternSport";
                _autoNameString = @"运动模式";
                _autoLogoString = @"owner_PatternTypeSport";
                _autoSelectedLogoString = @"owner_PatternTypeSport_Selected";
                break;
            default:
                break;
        }
    }
    
    return self;
}


//重置 转速
- (void)setRotateSpeedStr:(NSString *)rotateSpeedStr
{
    if ([_rotateSpeedStr isEqualToString:rotateSpeedStr] == NO)
    {
        
        NSDictionary *dict = @{RotateSpeedKey:rotateSpeedStr,ValveDelayKey:self.valveDelayStr};
        
        
        [UserDefaults setObject:dict forKey:_localKeyStr];
        [UserDefaults synchronize];
        
        
        _rotateSpeedStr = rotateSpeedStr;
    }
}

- (NSString *)rotateSpeedStr
{
    NSDictionary *dict = [UserDefaults objectForKey:_localKeyStr];
    
    if (dict && [dict isKindOfClass:[NSDictionary class]] && dict.allKeys.count > 0)
    {
        NSString *rotateSpeedStr = dict[RotateSpeedKey];
        
        return rotateSpeedStr;
    }
    else
    {
        NSString *string = @"4000";
        switch (_autoType)
        {
            case BoxControlAutoPatternComfortable:
                string = @"4000";
                break;
            case BoxControlAutoPatternGeneral:
                string = @"3000";
                break;
            case BoxControlAutoPatternSport:
                string = @"2000";
                break;
            default:
                break;
        }
        return string;
    }
}


//重置 阀门延迟
- (void)setValveDelayStr:(NSString *)valveDelayStr
{
    if ([_valveDelayStr isEqualToString:valveDelayStr] == NO)
    {
        NSDictionary *dict = @{RotateSpeedKey:self.rotateSpeedStr,ValveDelayKey:valveDelayStr};
        [UserDefaults setObject:dict forKey:_localKeyStr];
        [UserDefaults synchronize];

        
        _valveDelayStr = valveDelayStr;
    }
}

- (NSString *)valveDelayStr
{
    NSDictionary *dict = [UserDefaults objectForKey:_localKeyStr];
    
    if (dict && [dict isKindOfClass:[NSDictionary class]] && dict.allKeys.count > 0)
    {
        NSString *valveDelayStr = dict[ValveDelayKey];
        
        return valveDelayStr;
    }
    else
    {
        NSString *string = @"1S";
        switch (_autoType)
        {
            case BoxControlAutoPatternComfortable:
                string = @"1S";
                break;
            case BoxControlAutoPatternGeneral:
                string = @"3S";
                break;
            case BoxControlAutoPatternSport:
                string = @"5S";
                break;
            default:
                break;
        }
        return string;
    }
}


- (void)setIsDefault:(BOOL)isDefault
{
    if (_isDefault != isDefault)
    {
        _isDefault = isDefault;
        
        //默认情况下设置为默认
        if (isDefault == YES)
        {
            NSLog(@"%@ ====== 默认 ",self.autoNameString);
            
            [LocalConfigurationData setBoxControlAutoPattern:self.autoType];
        }
    }
}

- (BOOL)isDefault
{
    if ([LocalConfigurationData getBoxControlPattern] == self.autoType)
    {
        NSLog(@"%@ ----- YES",self.autoNameString);

        return YES;
    }
    else
    {
        NSLog(@"%@ ----- NO",self.autoNameString);

        return NO;
    }
}

//恢复默认设置
- (void)recoverDefaultSettings
{
    NSDictionary *dict = @{RotateSpeedKey:@"1000",ValveDelayKey:@"1S"};
    switch (_autoType)
    {
        case BoxControlAutoPatternComfortable:
            dict = @{RotateSpeedKey:@"4000",ValveDelayKey:@"1S"};
            break;
        case BoxControlAutoPatternGeneral:
            dict = @{RotateSpeedKey:@"3000",ValveDelayKey:@"3S"};
            break;
        case BoxControlAutoPatternSport:
            dict = @{RotateSpeedKey:@"2000",ValveDelayKey:@"5S"};
            break;
        default:
            break;
    }
    
    [UserDefaults setObject:dict forKey:_localKeyStr];
    [UserDefaults synchronize];
}

@end
