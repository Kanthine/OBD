//
//  QiniuUploadHelper.h
//  SURE
//
//  Created by 苏沫离 on 16/12/14.
//  Copyright © 2016年 longlong. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QiniuUploadHelper : NSObject

@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);
@property (copy, nonatomic)  void (^singleFailureBlock)();

@property (nonatomic ,copy) void(^finishBlock)(NSArray *urlArray ,NSError *error);

+ (instancetype)sharedUploadHelper;


@end
