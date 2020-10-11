//
//  QNManager.m
//  SURE
//
//  Created by 苏沫离 on 16/11/18.
//  Copyright © 2016年 longlong. All rights reserved.
//

#define Domain @"http://fruitsimage.qiniudn.com/"

#import "QNManager.h"

#import "UIImage+Extend.h"
#import "TimeStamp.h"
#import <QiniuSDK.h>

#import "AFNetAPIClient.h"
#import "FilePathManager.h"

@implementation QNManager

static QNUploadManager *upLoadManager = nil;

+ (QNUploadManager *)standardQNUploadManager
{
    static dispatch_once_t rootOnceToken;
    dispatch_once(&rootOnceToken, ^
                  {
                      if (upLoadManager == nil)
                      {
                          upLoadManager = [[QNUploadManager alloc] init];
                      }
                  });

    return upLoadManager;
}

+ (void)updateLoadImage:(UIImage *)image ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,BOOL isSucceed))block
{
    [QNManager getQiniuUploadTokenCompletionBlock:^(NSString *tokenString, NSError *error)
    {
        NSString *filePath = [QNManager getImagePath:image];
        
        [QNManager uploadImageToQNFilePath:filePath ProgressBlock:^(float progress)
         {
             progressBlock(progress);
             
         } UpLoadToken:tokenString CompletionBlock:^(NSString *urlString, BOOL isSucceed) {
             if (isSucceed)
             {
                 block(urlString ,YES);
             }
             else
             {
                 block(nil ,NO);
             }
         }];
    }];
}

+ (void)uploadImageToQNFilePath:(NSString *)filePath ProgressBlock:(void (^) (float progress))progressBlock UpLoadToken:(NSString *)tokenString CompletionBlock:(void (^) (NSString *urlString ,BOOL isSucceed))block
{
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //key 值唯一 上传过之后 key值不可重复
    NSString *time = [TimeStamp createCurrentTimeToTimestamp];
    NSString *upKey = [NSString stringWithFormat:@"%@.png",time];

   QNUploadManager *manager = [QNManager standardQNUploadManager] ;
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:^(NSString *key, float percent)
    {
        progressBlock(percent);
                                                   
                                               }
                                                        params:@{ @"x:foo":@"fooval" }
                                                      checkCrc:YES
                                            cancellationSignal:nil];
    
    
    
    [manager putFile:filePath key:upKey token:tokenString complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
    {
        if (!info.error)
        {
            NSString *contentURL = [NSString stringWithFormat:@"%@%@",Domain,key];
            
            block (contentURL ,YES);
            NSLog(@"info = %@ key === %@ resp ------- %@",info,key,resp);

            NSLog(@"QN Upload Success URL= %@",contentURL);
            
        }
        else
        {
            block (nil ,NO);
            NSLog(@"%@",info.error);
        }
        
    } option:opt];
}

//获取七牛的token
+ (void)getQiniuUploadTokenCompletionBlock:(void (^) (NSString *tokenString ,NSError *error))block
{
    NSString *urlString = [NSString stringWithFormat:@"http://sureapi.dt87.cn/public_api/get_qiniu_token"];
    
    [[AFNetAPIClient sharedClient] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
//         NSDictionary *originalDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         NSString *tokenString = [responseObject objectForKey:@"upToken"];
         
         if (tokenString)
         {
             block(tokenString,nil);
         }
         else
         {
             NSError *error = [NSError errorWithDomain:@"获取token失败" code:100 userInfo:nil];
             
             block(nil,error);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
     }];
}

//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image
{
    Image = [Image compressToMaxDataSizeKBytes:10 * 1024];
    
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil)
    {
        data = UIImageJPEGRepresentation(Image, 1.0);
    }
    else
    {
        data = UIImagePNGRepresentation(Image);
    }
    
    NSString *filePath = [FilePathManager getImageFilePathString];
    
    BOOL isSuccess = [data writeToFile:filePath atomically:YES];
    
    if (isSuccess)
    {
        return filePath;
    }
    
    NSLog(@"filePath === %@",filePath);
    
    return filePath;
}


@end
