//
//  WHYSizeManager.m
//  NewXinLing
//
//  Created by Why on 16/1/6.
//  Copyright © 2016年 why. All rights reserved.
//

#import "WHYSizeManager.h"

@implementation WHYSizeManager
+ (float)getRelativelyHeight:(float)originalHeight{
    return (originalHeight*ScreenHeight)/IPHONT5SHeight;
}
+ (float)getRelativelyWeight:(float)originalWeight{
    return (originalWeight*ScreenWidth)/IPHONE5Weight;
}

+ (float)getRelativelyHeight:(float)originalHeight comparedHeight:(float)comparedHeight{
    float hegith = (comparedHeight*ScreenHeight)/IPHONT5SHeight;
    return (originalHeight*ScreenHeight)/hegith;
}
@end
