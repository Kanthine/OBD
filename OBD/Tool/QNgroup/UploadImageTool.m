//
//  UploadImageTool.m
//  SURE
//
//  Created by 苏沫离 on 16/12/14.
//  Copyright © 2016年 longlong. All rights reserved.
//

#define QiNiuBaseUrl  @"http://fruitsimage.qiniudn.com/"


#import "UploadImageTool.h"
#import"QiniuUploadHelper.h"

#import"AFNetAPIClient.h"
#import "FilePathManager.h"
#import "TimeStamp.h"



@implementation UploadImageTool

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


+ (void)upLoadImage:(UIImage *)image ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,NSError *error))block
{
    [UploadImageTool getQiniuUploadTokenCompletionBlock:^(NSString *tokenString, NSError *error)
     {
         NSString *filePath = [UploadImageTool getImagePath:image];
         
         [UploadImageTool uploadImageToQNFilePath:filePath ProgressBlock:^(float progress)
          {
//                  progressBlock(progress);
              
              
          } UpLoadToken:tokenString CompletionBlock:^(NSString *urlString, BOOL isSucceed)
         {
             
             
             
              if (isSucceed)
              {
                  block(urlString ,nil);
              }
              else
              {
                  NSError *error = [NSError errorWithDomain:@"上传失败" code:100 userInfo:nil];
                  block(nil ,error);
              }
          }];
     }];

}

+ (void)upLoadImages:(NSArray *)imageArray ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSArray *urlArray ,NSError *error))block
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    __block CGFloat totalProgress = 0.0f;
    __block CGFloat partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    QiniuUploadHelper *uploadHelper = [QiniuUploadHelper sharedUploadHelper];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    

    
    uploadHelper.singleFailureBlock = ^()
    {
        NSError *error = [NSError errorWithDomain:@"上传七牛失败" code:100 userInfo:nil];
        NSLog(@"error ==== %@",error);
        block(nil,error);
        return;
    };
    
    uploadHelper.singleSuccessBlock  = ^(NSString *url)
    {
        [resultArray addObject:url];
        totalProgress += partProgress;
        progressBlock(totalProgress);
        currentIndex++;
        if ([resultArray count] == [imageArray count])
        {
            block([resultArray copy],nil);
            return;
        }
        else
        {
            NSLog(@"url ==== %@---%ld",url,(unsigned long)currentIndex);
            
            if (currentIndex < imageArray.count)
            {
                
                
                id obj = imageArray[currentIndex];
                
                if ([obj isKindOfClass:[UIImage class]]
                    )
                {
                    //图片上传 obj为上传的图片
                    [UploadImageTool upLoadImage:imageArray[currentIndex] ProgressBlock:nil CompletionBlock:^(NSString *urlString, NSError *error)
                     {
                         if (error)
                         {
                             weakHelper.singleFailureBlock();
                         }
                         else
                         {
                             weakHelper.singleSuccessBlock(urlString);
                         }
                     }];

                }
                else if ([obj isKindOfClass:[NSString class]])
                {
                    //视频  obj 为视频本地地址
                    [UploadImageTool uploadVideo:obj ProgressBlock:nil CompletionBlock:^(NSString *urlString, NSError *error)
                    {
                        if (error)
                        {
                            weakHelper.singleFailureBlock();
                        }
                        else
                        {
                            weakHelper.singleSuccessBlock(urlString);
                        }
                    }];
                    
                    
                    
                }
                
            }
        }
    };
    
    
    
    
    id firstObj = imageArray[0];
    
    if ([firstObj isKindOfClass:[UIImage class]]
        )
    {
        //图片上传 obj为上传的图片
        [UploadImageTool upLoadImage:firstObj ProgressBlock:nil CompletionBlock:^(NSString *urlString, NSError *error)
         {
             if (error)
             {
                 weakHelper.singleFailureBlock();
             }
             else
             {
                 weakHelper.singleSuccessBlock(urlString);
             }
         }];
        
    }
    else if ([firstObj isKindOfClass:[NSString class]])
    {
        //视频  obj 为视频本地地址
        [UploadImageTool uploadVideo:firstObj ProgressBlock:nil CompletionBlock:^(NSString *urlString, NSError *error)
         {
             if (error)
             {
                 weakHelper.singleFailureBlock();
             }
             else
             {
                 weakHelper.singleSuccessBlock(urlString);
             }
         }];
        
        
        
    }

    
    

}

+ (void)uploadImageToQNFilePath:(NSString *)filePath ProgressBlock:(void (^) (float progress))progressBlock UpLoadToken:(NSString *)tokenString CompletionBlock:(void (^) (NSString *urlString ,BOOL isSucceed))block
{
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //key 值唯一 上传过之后 key值不可重复
    NSString *time = [TimeStamp createCurrentTimeToTimestamp];
    
    NSString *upKey = nil;
    if ([filePath containsString:@"status.png"])
    {
        upKey = [NSString stringWithFormat:@"%@FileImage.png",time];
    }
    else
    {
        upKey = [NSString stringWithFormat:@"%@FileVideo.mp4",time];
    }
    
    NSLog(@"upKey ======= %@",upKey);
    
    
    QNUploadManager *manager = [UploadImageTool standardQNUploadManager] ;
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:^(NSString *key, float percent)
                           {
                               progressBlock(percent);
                               
                           }
                                                        params:@{ @"x:foo":@"fooval" }
                                                      checkCrc:YES
                                            cancellationSignal:nil];
    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    [manager putFile:filePath key:upKey token:tokenString complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
     {
         if (!info.error)
         {
             NSString *contentURL = [NSString stringWithFormat:@"%@%@",QiNiuBaseUrl,key];
             
             block (contentURL ,YES);
             
             NSLog(@"QN Upload Success URL= %@",contentURL);
             
         }
         else
         {
             block (nil ,NO);
             NSLog(@"info.error =========== %@",info.error);
         }
         
     } option:opt];
}


//error mark -- 必须设置获取七牛token服务器地址,然后获取token返回 --(确认设置后,删除此行)
//获取七牛的token
+ (void)getQiniuUploadTokenCompletionBlock:(void (^) (NSString *tokenString ,NSError *error))block
{
    NSString *urlString = [NSString stringWithFormat:@"http://sureapi.dt87.cn/public_api/get_qiniu_token"];
    
    [[AFNetAPIClient sharedClient] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSString *tokenString = [responseObject objectForKey:@"upToken"];
         
         NSLog(@"responseObject ======= %@",responseObject);
         
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
    
    return filePath;
}

+ (void)uploadVideo:(NSString *)videoPath ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,NSError *error))block
{
    
    [UploadImageTool getQiniuUploadTokenCompletionBlock:^(NSString *tokenString, NSError *error)
     {
         [UploadImageTool uploadImageToQNFilePath:videoPath ProgressBlock:^(float progress)
          {
              
          } UpLoadToken:tokenString CompletionBlock:^(NSString *urlString, BOOL isSucceed)
          {
              if (isSucceed)
              {
                  block(urlString ,nil);
              }
              else
              {
                  NSError *error = [NSError errorWithDomain:@"上传失败" code:100 userInfo:nil];
                  block(nil ,error);
              }
          }];
     }];
    

    
    
}


@end
