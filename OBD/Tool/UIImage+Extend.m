//
//  UIImage+Extend.m
//  GainInvest
//
//  Created by 苏沫离 on 17/2/7.
//  Copyright © 2017年 longlong. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (UIImage *)loadNavBarBackgroundImage
{
    UIImage *oldImage = [UIImage imageNamed:@"navBar"];
    
//    UIImage *newImage = [oldImage scaleToSize:CGSizeMake(ScreenWidth, 64)];
    
    return oldImage;
}




- (UIImage *)compressToMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f)
    {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes)
        {
            break;
        }
        else
        {
            lastData = dataKBytes;
        }
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}


@end
