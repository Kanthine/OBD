//
//  FilePathManager.h
//  GainInvest
//
//  Created by 苏沫离 on 17/2/9.
//  Copyright © 2017年 longlong. All rights reserved.
//


#define HttpCache @"HttpCache"
#define ImageFile @"ImageFile"


#import <Foundation/Foundation.h>

@interface FilePathManager : NSObject

/*
 * 获取启动页图片地址
 */
+ (NSString *)getLanchImageDefaultPath;

/*
 * 判断缓存文件夹是否存在 不存在则创建
 */
+ (NSString *)createHttpCacheFolderIfNotExist;

/*
 * 获取缓存路径
 */
+ (NSString *)getHTTPCachePathWithURL:(NSString *)url params:(id)params;

/*
 * 获取咨询默认分类路径
 */
+ (NSString *)getConsultDefaultKindFilePath;

/*
 * 获取一个图片地址
 */
+ (NSString *)getImageFilePathString;


@end
