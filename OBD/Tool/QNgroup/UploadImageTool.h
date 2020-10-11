//
//  UploadImageTool.h
//  SURE
//
//  Created by 苏沫离 on 16/12/14.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>

@interface UploadImageTool : NSObject

//获取七牛上传token
+ (void)getQiniuUploadTokenCompletionBlock:(void (^) (NSString *tokenString ,NSError *error))block;

/**
 *上传图片
 *param image需要上传的image
 *param progress上传进度block
 *param urlString成功block返回url地址
 *param error失败block
 */
+ (void)upLoadImage:(UIImage *)image ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,NSError *error))block;

/*
 * 上传多张图片,按队列依次上传
 * imageArray 包含两种类型：UIImage为上传图片 NSString为视频本地地址，上传的是视频
 *
 *  block --> urlArray：返回的资源地址:包含有video字段的为视频，包含有image字段的为图片
 */
+ (void)upLoadImages:(NSArray *)imageArray ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSArray *urlArray ,NSError *error))block;

//上传视频
+ (void)uploadVideo:(NSString *)videoPath ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,NSError *error))block;



@end
