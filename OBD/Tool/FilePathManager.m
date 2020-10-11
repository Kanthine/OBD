//
//  FilePathManager.m
//  GainInvest
//
//  Created by 苏沫离 on 17/2/9.
//  Copyright © 2017年 longlong. All rights reserved.
//

#import "FilePathManager.h"


#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)
+ (NSString *)hybnetworking_md5:(NSString *)string;
@end

@implementation NSString (md5)
+ (NSString *)hybnetworking_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

@end




@implementation FilePathManager

/*
 * 获取启动页图片地址
 */
+ (NSString *)getLanchImageDefaultPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    
    NSString *folderPath = [path stringByAppendingPathComponent:@"launch.png"];

    return folderPath;

}

//当前时间戳
+(NSString*)createCurrentTimeToTimestamp
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)createHttpCacheFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    
    NSString *folderPath = [path stringByAppendingPathComponent:HttpCache];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir)
        {
            NSLog(@"创建缓存文件夹失败");
            return folderPath;
        }
        return folderPath;
    }
    return folderPath;
}

+ (NSString *)getHTTPCachePathWithURL:(NSString *)url params:(id)params
{
    
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || ((NSDictionary *)params).count == 0)
    {
        return url;
    }
    
    
    NSString *queries = @"";
    for (NSString *key in params)
    {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSSet class]])
        {
            continue;
        }
        else
        {
            
            
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1)
    {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    
    
    if (queries.length > 1)
    {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound)
        {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        }
        else
        {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    
    NSString *directoryPath = [FilePathManager createHttpCacheFolderIfNotExist];//沙盒文件
    NSString *absoluteURL = url.length == 0 ? queries : url;//url地址 + 参数
    NSString *key = [NSString hybnetworking_md5:absoluteURL];//地址进行MD5加密
    NSString *path = [directoryPath stringByAppendingPathComponent:key];
    
    return path;
}

+ (NSString *)getConsultDefaultKindFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *folderPath = [path stringByAppendingPathComponent:@"ConsultDefaultKind.plist"];
    return folderPath;
}


+ (NSString *)createImageFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    
    NSString *folderPath = [path stringByAppendingPathComponent:ImageFile];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir)
        {
            NSLog(@"创建图片文件夹失败");
            return folderPath;
        }
        return folderPath;
    }
    return folderPath;
}

+ (NSString *)getImageFilePathString
{
    NSString *path = [FilePathManager createImageFolderIfNotExist];
    NSString *dateString = [FilePathManager createCurrentTimeToTimestamp];
    
    NSString *fileName = [[path stringByAppendingPathComponent:dateString] stringByAppendingString:@"status.png"];
    
    return fileName;
}

@end
