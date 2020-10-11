//
//  FWDBrokenLineView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/8.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,BrokenLineType)
{
    BrokenLineTypeEngine = 0,//发动机负荷
    BrokenLineTypeThrottle,//节气门开度
};

@interface FWDBrokenLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame Type:(BrokenLineType)lineType;

@end
