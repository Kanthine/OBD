//
//  BoxControlAutoModelConfiguration.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/22.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalConfigurationData.h"


@interface BoxControlAutoModelConfiguration : NSObject

@property (nonatomic ,assign,readonly) BoxControlAutoPattern autoType;//模式
@property (nonatomic ,copy,readonly) NSString *autoNameString;//模式名字
@property (nonatomic ,copy,readonly) NSString *autoLogoString;//模式Logo(图片资源名字)
@property (nonatomic ,copy,readonly) NSString *autoSelectedLogoString;//模式Logo(图片资源名字)

@property (nonatomic ,copy) NSString *rotateSpeedStr;//设置转速
@property (nonatomic ,copy) NSString *valveDelayStr;//阀门延迟
@property (nonatomic ,assign) BOOL isDefault;//是否为默认选项


- (instancetype)initWithConfigurationType:(BoxControlAutoPattern)autoType;

//恢复默认设置
- (void)recoverDefaultSettings;

@end
