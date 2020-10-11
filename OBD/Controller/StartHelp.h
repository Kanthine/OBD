//
//  StartHelp.h
//  XinLing
//
//  Created by 利 韩 on 15/2/10.
//  Copyright (c) 2015年 利 韩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StartHelp : NSObject

+ (BOOL)isFirstLaunchApp;

+ (void)saveIsFirstOpen:(BOOL)isFirst;

+ (BOOL)isGetJXMoeny;

+ (void)saveHadGetJXMoney:(BOOL)isGet;

+ (void)removeJXMoney;

+ (BOOL)isFirstIntro;

+ (void)saveHadIntro:(BOOL)isGet;

+ (BOOL)isFirstIntoGoodsDetial;

+ (void)saveHadGoodsDetail:(BOOL)isFirstDetail;

@end
