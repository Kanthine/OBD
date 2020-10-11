//
//  AppDelegate+UM.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "AppDelegate+UM.h"

#import <UMMobClick/MobClick.h>

@implementation AppDelegate (UM)

- (void)um_Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 友盟统计
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    UMConfigInstance.appKey = YMAPPKEY;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    
    // 友盟登录
    {
        [[UMSocialManager defaultManager] openLog:YES];
        
        [[UMSocialManager defaultManager] setUmSocialAppkey:@"58f9a6c48f4a9d0a72000fbf"];
        [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        
        UMSocialLogInfo(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
        
        
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx1eaef4131456c6a2" appSecret:@"c46ca478b8dea53486812f47d3ee1d36" redirectURL:@"http://sureapi.dt87.cn/pay/notify_url"];
        

        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101398826"  appSecret:@"bab9060151842e0b6218c06d56418bdf" redirectURL:@"http://sureapi.dt87.cn/pay/notify_url"];
        
        //facebook
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"281971438880757" appSecret:@"4de3c5f319145de831f2af39aa667473" redirectURL:@""];
    }
    
    
    
    
    
}

@end
