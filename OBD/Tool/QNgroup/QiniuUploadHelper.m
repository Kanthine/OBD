//
//  QiniuUploadHelper.m
//  SURE
//
//  Created by 苏沫离 on 16/12/14.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import "QiniuUploadHelper.h"


@implementation QiniuUploadHelper


static id _instance = nil;

+ (instancetype)sharedUploadHelper
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}



- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}


@end
