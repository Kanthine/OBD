//
//  TimeStamp.h
//  SURE
//
//  Created by 苏沫离 on 16/11/10.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeStamp : NSObject

/* 
 * 当前时间转时间戳
 */
+(NSString*)createCurrentTimeToTimestamp;

/*
 *时间戳转时间
 */
+ (NSString*)timeStampSwitchTime:(NSString*)timeStamp;

@end
