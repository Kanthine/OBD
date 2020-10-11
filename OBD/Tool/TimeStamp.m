//
//  TimeStamp.m
//  SURE
//
//  Created by 苏沫离 on 16/11/10.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import "TimeStamp.h"

@implementation TimeStamp

+(NSString*)createCurrentTimeToTimestamp
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    
//    NSLog(@"timeZone.knownTimeZoneNames ========== %@",timeZone.knownTimeZoneNames);
    
    NSDate *datenow = [NSDate date];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;
}

+ (NSString*)timeStampSwitchTime:(NSString*)timeStamp
{
    if ([timeStamp isKindOfClass:[NSString class]])
    {
        if (timeStamp != nil && timeStamp.length > 0)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            
//            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]  + 8 *3600];
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];

            
            NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        
            
            return confromTimespStr;
        }
        else
        {
            return @"";
        }
    }
    else
    {
        return @"";
    }
    
}

@end
