//
//  StartHelp.m
//  XinLing
//
//  Created by 利 韩 on 15/2/10.
//  Copyright (c) 2015年 利 韩. All rights reserved.
//
#define APPVersion @"APPVersion"
#define UserDefaults [NSUserDefaults standardUserDefaults]

#import "StartHelp.h"

@implementation StartHelp

+ (BOOL)isFirstLaunchApp
{
    BOOL isFirstOpen = NO;
    @try
    {
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *lastRunVersion = [UserDefaults objectForKey:APPVersion];

        if (lastRunVersion == nil)
        {
            [UserDefaults setObject:currentVersion forKey:APPVersion];
            [UserDefaults synchronize];
            isFirstOpen = YES;
        }
        else if ([lastRunVersion isEqualToString:currentVersion] == NO)
        {
            [UserDefaults setObject:currentVersion forKey:APPVersion];
            [UserDefaults synchronize];
            isFirstOpen = YES;
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    
    
    return isFirstOpen;
}

+ (void)saveIsFirstOpen:(BOOL)isFirst
{
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            [userDefaults setBool:isFirst forKey:@"IsFirstOpen"];
            [userDefaults synchronize];
            NSLog(@"是否第一次打开软件：%d", isFirst);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"是否第一次打开软件失败");
    }
    @finally {
        
    }
}

+ (BOOL)isGetJXMoeny {
    
    BOOL isGetJXMoeny = NO;
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            isGetJXMoeny = [userDefaults boolForKey:@"IsGetJXMoeny"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSLog(@"是否领取：%d", isGetJXMoeny);
    return !isGetJXMoeny;
}

+ (void)saveHadGetJXMoney:(BOOL)isGet {
    
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            [userDefaults setBool:isGet forKey:@"IsGetJXMoeny"];
            [userDefaults synchronize];
            NSLog(@"是否第一次领取：%d", isGet);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"是否第一次领取失败");
    }
    @finally {
        
    }
}

+ (void)removeJXMoney {
    
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            [userDefaults setBool:NO forKey:@"IsGetJXMoeny"];
            [userDefaults synchronize];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


+ (BOOL)isFirstIntro {
 
    BOOL isFirstIntro = NO;
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            isFirstIntro = [userDefaults boolForKey:@"isFirstIntro"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSLog(@"是否点击精选：%d", isFirstIntro);
    return !isFirstIntro;
}

+ (void)saveHadIntro:(BOOL)isFirst {
    
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            [userDefaults setBool:isFirst forKey:@"isFirstIntro"];
            [userDefaults synchronize];
            NSLog(@"是否点击精选：%d", isFirst);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"是否点击精选失败");
    }
    @finally {
        
    }
}

+ (BOOL)isFirstIntoGoodsDetial {
    
    BOOL isFirstIntoGoodsDetial = NO;
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            isFirstIntoGoodsDetial = [userDefaults boolForKey:@"isFirstIntoGoodsDetial"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSLog(@"是否点击商品详情：%d", isFirstIntoGoodsDetial);
    return !isFirstIntoGoodsDetial;
}

+ (void)saveHadGoodsDetail:(BOOL)isFirstDetail {
    
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (userDefaults != nil)
        {
            [userDefaults setBool:isFirstDetail forKey:@"isFirstIntoGoodsDetial"];
            [userDefaults synchronize];
            NSLog(@"是否点商品详情：%d", isFirstDetail);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"是否点击商品详情");
    }
    @finally {
        
    }
}

@end
