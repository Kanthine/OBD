//
//  QNManager.h
//  SURE
//
//  Created by 苏沫离 on 16/11/18.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNManager : NSObject

/*
 *上传照片至七牛
 *
 *filePath 照片所在本地路径
 *
 *progressBlock 上传进度
 *
 *urlString 上传成功后拿到图片地址 发给服务器
 *
 */
+ (void)updateLoadImage:(UIImage *)image ProgressBlock:(void (^) (float progress))progressBlock CompletionBlock:(void (^) (NSString *urlString ,BOOL isSucceed))block;

@end
