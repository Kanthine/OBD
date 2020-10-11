//
//  AppDelegate+LaunchImage.h
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "AppDelegate.h"
#import "SpLanuchView.h"
@interface AppDelegate (LaunchImage)
<SpLanuchViewDelegate>

- (void)launch_Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
